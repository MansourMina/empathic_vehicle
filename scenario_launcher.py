# scenario_launcher.py
import carla
import json
import importlib.util
import sys
import os

def load_weather(json_path):
    with open(json_path) as f:
        data = json.load(f)
    return carla.WeatherParameters(
        cloudiness=data.get("cloudiness", 0.0),
        precipitation=data.get("precipitation", 0.0),
        sun_altitude_angle=data.get("sun_altitude_angle", 45.0),
        fog_density=data.get("fog_density", 0.0)
    )

def apply_weather(client, weather):
    world = client.get_world()
    world.set_weather(weather)

def run_scenario(scenario_path):
    spec = importlib.util.spec_from_file_location("scenario", scenario_path)
    scenario = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(scenario)

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python scenario_launcher.py <scenario.py> <weather.json>")
        sys.exit(1)

    scenario_path = sys.argv[1]
    weather_path = sys.argv[2]

    client = carla.Client("localhost", 2000)
    client.set_timeout(10.0)

    weather = load_weather(weather_path)
    apply_weather(client, weather)
    run_scenario(scenario_path)
