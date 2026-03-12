import os
import sys
from isaacsim import SimulationApp

# Set headless=True if you don't want the GUI to appear
simulation_app = SimulationApp({"headless": False})

# Now you can import other omniverse and isaac core modules
from omni.isaac.core import World
from omni.isaac.core.objects import DynamicCuboid
import numpy as np

def main():
    print("Initializing Isaac Sim...")
    
    # Inject Virtual Environment path if provided by Launch script
    venv_path = os.environ.get("VENV_PATH")
    if venv_path and venv_path not in sys.path:
        print(f"Adding Virtual Environment Path: {venv_path}")
        sys.path.append(venv_path)

    # Create the simulation world
    world = World()
    
    # Add a ground plane
    world.scene.add_default_ground_plane()

    # Add a dynamic red cube that will fall to the ground
    cube = world.scene.add(
        DynamicCuboid(
            prim_path="/World/cube",
            name="cube",
            position=np.array([0, 0, 2.0]), # Starts 2 meters up
            scale=np.array([0.5, 0.5, 0.5]),
            color=np.array([1.0, 0, 0]), # Red color
        )
    )
    
    # Reset the world to start the simulation
    world.reset()
    print("Isaac Sim initialized successfully! Added a red cube.")

    # Run the simulation loop
    # You can add your robot/scene interactions inside this loop
    while simulation_app.is_running():
        world.step(render=True)

    # Clean up when the application is closed
    simulation_app.close()

if __name__ == "__main__":
    main()
