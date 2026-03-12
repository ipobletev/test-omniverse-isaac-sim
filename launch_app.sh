#!/bin/bash

# Configuration
VENV_DIR=".venv"
REQUIREMENTS_FILE="requirements.txt"

echo "========================================"
echo "    Starting Isaac Sim Environment      "
echo "========================================"

# Step 1: Create virtual environment if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
    echo "[1/2] Creating virtual environment in $VENV_DIR..."
    python -m venv "$VENV_DIR"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create virtual environment. Ensure 'python' is in your PATH."
        exit 1
    fi
else
    echo "[1/2] Virtual environment already exists."
fi

# Step 2: Install requirements
if [ -f "$REQUIREMENTS_FILE" ]; then
    echo "[2/2] Installing dependencies from $REQUIREMENTS_FILE..."
    # Use the venv's Python directly so we don't depend on the shell
    # activation working correctly on every platform.
    VENV_PYTHON="$VENV_DIR/Scripts/python"
    if [ ! -x "$VENV_PYTHON" ]; then
        echo "Error: virtual environment python not found at $VENV_PYTHON"
        exit 1
    fi
    "$VENV_PYTHON" -m pip install -r "$REQUIREMENTS_FILE"
else
    echo "[2/2] No $REQUIREMENTS_FILE found. Skipping dependency installation."
fi


# Step 3: Run Isaac Sim
# NOTE: use Isaac's own python executable. We don't activate the venv while
# launching because Isaac ships with its own isolated environment.
ISAAC_PYTHON="/c/isaacsim/python.bat"
MAIN_SCRIPT="test/test_world.py"

echo "[3/3] Launching Isaac Sim..."
if [ -f "$ISAAC_PYTHON" ]; then
    VENV_SITE_PACKAGES=$(pwd)/$VENV_DIR/Lib/site-packages
    echo "Running script: $MAIN_SCRIPT"
    export VENV_PATH="$VENV_SITE_PACKAGES"
    "$ISAAC_PYTHON" "$MAIN_SCRIPT"
else
    echo "Error: Isaac Sim python executable not found at $ISAAC_PYTHON"
    exit 1
fi

echo "========================================"
echo "          Simulation Closed             "
echo "========================================"
