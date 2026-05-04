from flask import Flask, jsonify
from flask_cors import CORS
from pyswip import Prolog, Atom
import os

app = Flask(__name__)
CORS(app)

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

pl = Prolog()
pl.consult(os.path.join(BASE_DIR, "optimizer.pl"))


def atom_str(val):
    """Convertit un Atom pyswip ou toute valeur en str Python."""
    return str(val)


def safe_atom(value: str) -> str:
    """
    Sécurise une valeur pour l'injecter dans une query Prolog
    en l'entourant de quotes simples.
    """
    cleaned = value.replace("'", "").replace("\\", "").replace("(", "").replace(")", "")
    return f"'{cleaned}'"


# ── Cache du planning généré au démarrage ────────────────────────────────────

def build_schedule_cache():
    """
    Appelle generate_schedule/1 une seule fois et retourne la liste
    de sessions sous forme de dicts Python.
    """
    print("[BOOT] Generating schedule via generate_schedule/1 ...")
    raw_sessions = []
    try:
        # On récupère d'abord la liste Prolog brute
        results = list(pl.query("generate_schedule(S), member(session(C,G,R,Sl), S), slot(Sl, Day, Start, End, _)"))
        for row in results:
            raw_sessions.append({
                "course": atom_str(row["C"]),
                "group":  atom_str(row["G"]),
                "room":   atom_str(row["R"]),
                "slot":   atom_str(row["Sl"]),
                "day":    atom_str(row["Day"]),
                "start":  atom_str(row["Start"]),
                "end":    atom_str(row["End"]),
            })
        print(f"[BOOT] Schedule cache ready: {len(raw_sessions)} sessions.")
    except Exception as e:
        print(f"[ERROR] build_schedule_cache: {e}")
    return raw_sessions


def build_prolog_schedule_term():
    """
    Reconstruit un terme Prolog liste '[session(...), ...]' depuis le cache,
    utilisable directement dans les queries d'évaluation/validation.
    """
    terms = []
    for s in SCHEDULE_CACHE:
        terms.append(
            f"session({s['course']},{s['group']},{s['room']},{s['slot']})"
        )
    return "[" + ",".join(terms) + "]"


# Génération au démarrage
SCHEDULE_CACHE = build_schedule_cache()


# ── Endpoints ─────────────────────────────────────────────────────────────────

@app.route("/schedule")
def get_schedule():
    return jsonify(SCHEDULE_CACHE)


@app.route("/validate")
def get_validate():
    checks = {}
    schedule_term = build_prolog_schedule_term()

    def run_check(name, predicate):
        try:
            result = list(pl.query(f"S = {schedule_term}, {predicate}(S)"))
            checks[name] = len(result) > 0
        except Exception as e:
            print(f"[ERROR] validation check '{name}': {e}")
            checks[name] = False

    run_check("no_room_conflicts",              "validate_no_room_conflicts")
    run_check("no_group_conflicts",             "validate_no_group_conflicts")
    run_check("no_instructor_conflicts",        "validate_no_instructor_conflicts")
    run_check("all_equipment_ok",               "validate_all_equipment")
    run_check("all_capacity_ok",                "validate_all_capacity")
    run_check("all_instructor_availability",    "validate_all_instructor_availability")
    run_check("energy_ok",                      "validate_all_energy")

    overall = all(checks.values())
    return jsonify({"valid": overall, "checks": checks})


@app.route("/optimize/report")
def get_optimize_report():
    schedule_term = build_prolog_schedule_term()

    try:
        results = list(pl.query(
            f"S = {schedule_term},"
            "evaluate_schedule(S, report(Energy, Imbalance, Variance, Composite))"
        ))
    except Exception as e:
        print(f"[ERROR] /optimize/report (evaluate): {e}")
        return jsonify({"error": str(e)}), 500

    if not results:
        return jsonify({"error": "Could not evaluate schedule"}), 500

    r = results[0]

    # Énergie par jour
    daily = []
    try:
        for row in pl.query(
            f"S = {schedule_term},"
            "member(D, [monday,tuesday,wednesday,thursday,friday,saturday]),"
            "day_total_energy(S, D, E)"
        ):
            daily.append({"day": atom_str(row["D"]), "energy": float(row["E"])})
    except Exception as e:
        print(f"[ERROR] /optimize/report (daily energy): {e}")

    # Énergie par bâtiment
    buildings = []
    try:
        for row in pl.query(
            f"S = {schedule_term},"
            "building(B, Name, Threshold),"
            "findall(E, (member(D,[monday,tuesday,wednesday,thursday,friday,saturday]),"
            "building_energy_on_day(S,B,D,E)), Es),"
            "sum_list(Es, Total)"
        ):
            buildings.append({
                "id":           atom_str(row["B"]),
                "name":         atom_str(row["Name"]),
                "threshold":    int(row["Threshold"]),
                "weekly_total": float(row["Total"]),
            })
    except Exception as e:
        print(f"[ERROR] /optimize/report (buildings): {e}")

    weights = {}
    try:
        for row in pl.query("weight(K, V)"):
            weights[atom_str(row["K"])] = float(row["V"])
    except Exception as e:
        print(f"[ERROR] /optimize/report (weights): {e}")
        weights = {"energy": 0.5, "imbalance": 0.3, "variance": 0.2}

    return jsonify({
        "energy":    float(r["Energy"]),
        "imbalance": float(r["Imbalance"]),
        "variance":  float(r["Variance"]),
        "composite": float(r["Composite"]),
        "weights":   weights,
        "daily":     daily,
        "buildings": buildings,
    })


@app.route("/energy")
def get_energy():
    schedule_term = build_prolog_schedule_term()
    rows = []
    try:
        for row in pl.query(
            f"S = {schedule_term},"
            "building(B, Name, Threshold),"
            "member(D, [monday,tuesday,wednesday,thursday,friday,saturday]),"
            "building_energy_on_day(S, B, D, E)"
        ):
            rows.append({
                "building":  atom_str(row["B"]),
                "name":      atom_str(row["Name"]),
                "threshold": int(row["Threshold"]),
                "day":       atom_str(row["D"]),
                "energy":    float(row["E"]),
            })
    except Exception as e:
        print(f"[ERROR] /energy : {e}")
        return jsonify({"error": str(e)}), 500
    return jsonify(rows)


@app.route("/groups")
def get_groups():
    groups = []
    try:
        for row in pl.query("group(G, Level, Size)"):
            groups.append({
                "id":    atom_str(row["G"]),
                "level": atom_str(row["Level"]),
                "size":  int(row["Size"]),
                "type":  "group",
            })
        for row in pl.query("subgroup(SG, Parent, _, Size)"):
            groups.append({
                "id":     atom_str(row["SG"]),
                "parent": atom_str(row["Parent"]),
                "level":  atom_str(row["Parent"]),
                "size":   int(row["Size"]),
                "type":   "subgroup",
            })
    except Exception as e:
        print(f"[ERROR] /groups : {e}")
        return jsonify({"error": str(e)}), 500
    return jsonify(groups)


@app.route("/group/<group_id>")
def get_group_schedule(group_id):
    sessions = [s for s in SCHEDULE_CACHE if s["group"] == group_id]
    return jsonify(sessions)


@app.route("/repair/<course>/<group>")
def get_repair(course, group):
    schedule_term = build_prolog_schedule_term()
    safe_c = safe_atom(course)
    safe_g = safe_atom(group)
    query = (
        f"S = {schedule_term},"
        f"repair_session({safe_c}, {safe_g}, S, Room, Slot),"
        f"slot(Slot, Day, Start, End, _)"
    )
    try:
        results = list(pl.query(query))
    except Exception as e:
        print(f"[ERROR] /repair/{course}/{group} : {e}")
        return jsonify({"error": str(e)}), 500

    if not results:
        return jsonify({"found": False, "message": "No repair found — all slots taken."})

    r = results[0]
    return jsonify({
        "found":  True,
        "course": course,
        "group":  group,
        "room":   atom_str(r["Room"]),
        "slot":   atom_str(r["Slot"]),
        "day":    atom_str(r["Day"]),
        "start":  atom_str(r["Start"]),
        "end":    atom_str(r["End"]),
    })


@app.route("/rooms")
def get_rooms():
    schedule_term = build_prolog_schedule_term()
    rooms = []
    try:
        for row in pl.query(
            f"S = {schedule_term},"
            "room(R, Cap, Equip, Building, Cost),"
            "room_usage_count(S, R, Count)"
        ):
            rooms.append({
                "id":       atom_str(row["R"]),
                "capacity": int(row["Cap"]),
                "equip":    atom_str(row["Equip"]),
                "building": atom_str(row["Building"]),
                "cost":     int(row["Cost"]),
                "sessions": int(row["Count"]),
            })
    except Exception as e:
        print(f"[ERROR] /rooms : {e}")
        return jsonify({"error": str(e)}), 500
    return jsonify(rooms)


if __name__ == "__main__":
    print("Starting GL Scheduler API on http://localhost:5000")
    print("Endpoints:")
    print("  GET /schedule")
    print("  GET /validate")
    print("  GET /optimize/report")
    print("  GET /energy")
    print("  GET /groups")
    print("  GET /group/<group_id>")
    print("  GET /rooms")
    print("  GET /repair/<course>/<group>")
    app.run(debug=False, port=5000)