import sys
sys.path.append(r"M:\CARLA_0.9.12\PythonAPI\carla\dist\carla-0.9.12-py3.7-win-amd64.egg")

import glob
import os
import sys

try:
    sys.path.append(glob.glob(os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + '/carla/dist/carla-*%d.%d-%s.egg' % (
        sys.version_info.major,
        sys.version_info.minor,
        'win-amd64' if os.name == 'nt' else 'linux-x86_64'))[0])
except IndexError:
    pass


import carla
from carla import ColorConverter as cc
import random
import time

# Verbindet sich mit dem Carla-Server
client = carla.Client('localhost', 2000)
client.set_timeout(5.0)
world = client.get_world()

blueprint_library = world.get_blueprint_library()

# Zum Speichern der Akteure
actor_list = []

def spawn_vehicle_ahead():
    ego_vehicle = None
    npc_vehicle = None

    # Finde das Ego-Fahrzeug (z.B. dein Auto)
    for actor in world.get_actors().filter('vehicle.*'):
        if actor.attributes.get('role_name') == 'hero':  # dein Auto sollte role_name=hero haben
            ego_vehicle = actor
            break

    if not ego_vehicle:
        print("Kein Ego-Fahrzeug gefunden. Bitte stelle sicher, dass dein Auto den Role-Name 'hero' hat.")
        return None, None

    transform = ego_vehicle.get_transform()
    # Suche freies Spawnpunkt in Fahrtrichtung (vor deinem Auto)
    forward_vector = transform.get_forward_vector()
    spawn_location = transform.location + forward_vector * 20  # 20 Meter vor dir
    spawn_location.z += 0.5  # leicht anheben, damit es nicht im Boden steckt
    spawn_transform = carla.Transform(spawn_location, transform.rotation)

    npc_blueprints = blueprint_library.filter('vehicle.*')
    npc_bp = random.choice(npc_blueprints)

    if npc_bp.has_attribute('color'):
        color = random.choice(npc_bp.get_attribute('color').recommended_values)
        npc_bp.set_attribute('color', color)

    npc_vehicle = world.try_spawn_actor(npc_bp, spawn_transform)

    
    

    if npc_vehicle:
        npc_vehicle.set_autopilot(True)
        actor_list.append(npc_vehicle)
        print("NPC-Fahrzeug gespawnt.")
    else:
        print("Fehler beim Spawnen des NPC-Fahrzeugs.")

    return ego_vehicle, npc_vehicle

def sudden_stop(vehicle):
    if vehicle:
        print("Stoppe das Fahrzeug!")
        vehicle.set_autopilot(False)  # Autopilot deaktivieren
        
        control = carla.VehicleControl()
        control.throttle = 0.0
        control.brake = 1.0
        control.steer = 0.0
        control.hand_brake = True  # ← Handbremse ziehen für sofortigen Stopp
        vehicle.apply_control(control)

def reset_world():
    print("Reset: Lösche alle Fahrzeuge!")
    for actor in actor_list:
        actor.destroy()
    actor_list.clear()
    time.sleep(1.0)
    spawn_vehicle_ahead()

# ======== Hauptlogik =========
if __name__ == '__main__':
    ego_vehicle, npc_vehicle = spawn_vehicle_ahead()

    print("Drücke 's' + Enter für sudden stop, 'r' + Enter für Reset, oder 'q' + Enter zum Beenden.")

    while True:
        cmd = input("> ").lower().strip()
        if cmd == 's':
            sudden_stop(npc_vehicle)
        elif cmd == 'r':
            reset_world()
            ego_vehicle, npc_vehicle = spawn_vehicle_ahead()
        elif cmd == 'q':
            break
        else:
            print("Unbekannter Befehl. 's' für Stop, 'r' für Reset, 'q' für Quit.")

    # Alles sauber beenden
    for actor in actor_list:
        actor.destroy()
    print("Skript beendet.")
