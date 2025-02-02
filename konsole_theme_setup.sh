#!/bin/bash

# Define the GitHub repository URL
REPO_URL="https://github.com/daltonmenezes/aura-theme.git"
REPO_DIR="$HOME/aura-theme"

# Clone the repository if it doesn't exist already
if [ ! -d "$REPO_DIR" ]; then
    echo "Cloning Aura theme repository..."
    git clone "$REPO_URL" "$REPO_DIR"
else
    echo "Repository already exists. Pulling latest changes..."
    cd "$REPO_DIR" && git pull
fi

# Define the source path for the Konsole theme files
SOURCE_PATH="$REPO_DIR/packages/konsole"

# Define the destination path
DEST_PATH="$HOME/.local/share/konsole"

# Ensure the destination directory exists
mkdir -p "$DEST_PATH"

# Copy the theme files (Aura theme and Aura soft theme)
echo "Copying Konsole theme files..."
cp -r "$SOURCE_PATH/aura-theme.colorscheme" "$DEST_PATH"
cp -r "$SOURCE_PATH/aura-theme-soft.colorscheme" "$DEST_PATH"

# Notify the user
echo "Konsole Aura theme has been installed successfully!"

