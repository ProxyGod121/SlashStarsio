#!/bin/bash

# Directory where you want to setup swordbattle.io
DIR="swordbattle.io"

# Check if the directory already exists
if [ ! -d "$DIR" ]; then
    # Clone the repository if the directory doesn't exist
    git clone https://github.com/codergautam/swordbattle.io.git $DIR
fi

# Change to the repository directory
cd $DIR

# Check if Yarn is installed
if ! command -v yarn &> /dev/null
then
    echo "Yarn could not be found, installing..."
    npm install --global yarn
fi

# Install Concurrently if not installed
if ! command -v concurrently &> /dev/null
then
    echo "Concurrently could not be found, installing..."
    npm install -g concurrently
fi

# Install dependencies in server and client directories
echo "Installing dependencies in server directory..."
cd server
yarn install

echo "Installing dependencies in client directory..."
cd ../client
yarn install

# Use concurrently to run both server and client
echo "Starting server and client simultaneously..."
cd .. # Go back to the root directory of the project
concurrently "cd server && yarn start" "cd client && yarn start"

# Display message to visit the forum if any issues
echo "Both server and client are running. Visit https://iogames.forum/swordbattle for support if you face any issues."
