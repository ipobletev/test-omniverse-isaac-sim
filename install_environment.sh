#!/bin/bash

# Configuration
VENV_DIR=".venv"
REQUIREMENTS_FILE="requirements.txt"

echo "==================================================="
echo "    Starting Installation of Isaac Sim Environment "
echo "==================================================="

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

echo "========================================"
echo "          Installation Complete         "
echo "========================================"
