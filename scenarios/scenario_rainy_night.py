import carla
import time

def main():
    client = carla.Client("localhost", 2000)
    client.set_timeout(10.0)

    world = client.get_world()

    blueprint_library = world.get_blueprint_library()
    vehicle_bp = blueprint_library.filter("vehicle.audi.tt")[0]

    spawn_points = world.get_map().get_spawn_points()
    if not spawn_points:
        print("Keine Spawnpunkte gefunden!")
        return

    vehicle = world.try_spawn_actor(vehicle_bp, spawn_points[-1])

    if vehicle is None:
        print("Fahrzeug konnte nicht gespawnt werden.")
        return

    vehicle.set_autopilot(True)
    print("Fahrzeug im Regen-Nacht-Szenario gestartet.")

    time.sleep(20)

    vehicle.destroy()
    print("Szenario beendet.")

if __name__ == "__main__":
    main()
