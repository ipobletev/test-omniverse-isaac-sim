# Test Isaac Sim

This is a boilerplate test project to explore and learn how to initialize simulations using **NVIDIA Isaac Sim** via the Python API.

The main script currently generates a basic simulation environment (World), adds a Ground Plane to it, and spawns a dynamic red cube that falls due to gravity.

## 📋 Prerequisites

* **Python 3.11** installed 

## 🚀 How to Run

To make execution and dependency management seamless, this project uses a unified bash script. Because Isaac Sim needs to load proprietary environment variables and precompiled Omniverse libraries before starting Python, **these scripts cannot be executed using a standard Python executable** directly.

Instead of running Isaac Sim's `python.bat` manually every time, you can handle everything automatically using the launch script.

### Using Git Bash (Recommended)

Open your Git Bash terminal, make sure you are in the root directory of this project (`c:\GIT\sme\nvidia-omniverse\test-omniverse-isaac-sim`), and follow these two steps:

1. **Prepare the environment (once or after changing requirements):**
   ```bash
   ./install_environment.sh
   ```
   This creates the `.venv` folder and installs any packages listed in `requirements.txt`.

**What the scripts do:**
- `install_environment.sh`
  1. Checks for `.venv` and creates it if missing.
  2. Installs dependencies from `requirements.txt` using the venv's Python.

2. **Execute a application in external terminal**

    /c/isaacsim/python.bat test/test_world.py
