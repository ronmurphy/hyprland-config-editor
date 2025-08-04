#!/bin/bash

# Hyprland Config Editor - Quick Run Script

echo "🚀 Starting Hyprland Config Editor..."
echo "📁 Current directory: $(pwd)"

# Check if Quickshell is available
if ! command -v qs &> /dev/null; then
    echo "❌ Quickshell not found! Please install it first:"
    echo "   yay -S quickshell-git"
    echo "   OR build from source: https://github.com/outfoxxed/quickshell"
    exit 1
fi

# Check if shell.qml exists (we renamed from main.qml)
if [ ! -f "shell.qml" ]; then
    echo "❌ shell.qml not found in current directory!"
    echo "   Make sure you're in the project root directory"
    exit 1
fi

echo "✅ Found shell.qml"
echo "✅ Quickshell is available"
echo ""

# Show some debug info
echo "🔍 Debug Info:"
echo "   HOME: $HOME"
echo "   USER: $USER"
echo "   XDG_CONFIG_HOME: ${XDG_CONFIG_HOME:-$HOME/.config}"
echo "   Hypr config should be at: ${XDG_CONFIG_HOME:-$HOME/.config}/hypr"
echo ""

# Run the application
echo "🎯 Launching application..."
echo "Running with Quickshell..."

# Get the current user dynamically
CURRENT_USER=$(whoami)
echo "👤 Detected user: $CURRENT_USER"

# Build the config path dynamically using the detected user
CONFIG_PATH="/home/$CURRENT_USER/.config/hypr"
echo "📂 Using config path: $CONFIG_PATH"

# Verify the path exists
if [ -d "$CONFIG_PATH" ]; then
    echo "✅ Config directory exists"
else
    echo "⚠️  Config directory not found at $CONFIG_PATH"
    echo "   The app will still run but may not find configs"
fi

# Run the application with the detected username
echo "🚀 Starting application with username: $CURRENT_USER"

# Method: Write username to temporary file (most reliable)
echo "📝 Writing username to temporary file..."
TMP_FILE="/tmp/hyprland-config-editor-user.txt"
echo "$CURRENT_USER" > "$TMP_FILE"
echo "   Wrote '$CURRENT_USER' to $TMP_FILE"

# Start the application (it will read the username from the file)
echo "🚀 Starting application..."
qs -p shell.qml

# Check exit code
if [ $? -ne 0 ]; then
    echo "❌ Quickshell failed to run"
    echo "💡 Try running manually: qs -p shell.qml"
else
    echo "✅ Application closed normally"
fi

echo ""
echo "👋 Application closed"
