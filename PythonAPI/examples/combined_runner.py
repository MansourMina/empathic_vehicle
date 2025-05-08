import carla
import subprocess
import sys

def set_synchronous_mode():
    client = carla.Client('localhost', 2000)
    client.set_timeout(10.0)
    world = client.get_world()

    settings = world.get_settings()
    settings.synchronous_mode = True
    settings.fixed_delta_seconds = 0.03
    world.apply_settings(settings)

    print("✅ Synchronous mode and fixed delta time set.")

    # ⚠ Turn synchronous OFF again to prevent timeout in generate_traffic.py
    settings.synchronous_mode = False
    world.apply_settings(settings)
    print("✅ Switched back to asynchronous mode.")

def run_generate_traffic():
    # Run generate_traffic.py as a subprocess
    print("🚀 Starting generate_traffic.py...")
    result = subprocess.run([sys.executable, "generate_traffic.py"], capture_output=True, text=True)

    # Print output from generate_traffic.py
    print(result.stdout)
    if result.stderr:
        print("⚠ Errors/warnings from generate_traffic.py:")
        print(result.stderr)

def main():
    set_synchronous_mode()
    run_generate_traffic()

if __name__ == "__main__":
    main()
