#!/bin/bash
Hola
# Deployment script for Infinity Task Protocol on local ICP environment
# Based on the provided deployment instructions.

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Starting Infinity Task Protocol local deployment process..."

echo "1. Cloning the Infinity Task Protocol repository..."
#
git clone https://github.com/Infinity-Task-Protocol/Infinity-task-protocol.git
echo "   Repository cloned."

# Navigate to the project directory
PROJECT_DIR="Infinity-task-protocol"
if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: Directory $PROJECT_DIR was not cloned correctly. Ensure Git is installed and you have repository access."
    exit 1
fi
echo "2. Navigating to the project directory: $PROJECT_DIR"
#
cd "$PROJECT_DIR"
echo "   Current location: $(pwd)"

echo "3. Starting DFX in clean background mode..."
#
dfx start --clean --background
echo "   DFX started. This might take a few seconds..."

echo "4. Generating backend code (Candid Rust/TypeScript)..."
#
dfx generate backend
echo "   Backend code generated."

echo "5. Pulling DFX dependencies..."
#
dfx deps pull
echo "   DFX dependencies pulled."

echo "6. Initializing Internet Identity dependency (for user authentication)..."
#
dfx deps init internet_identity
echo "   Internet Identity initialized."

echo "7. Initializing ICP Ledger dependency for local environment..."
# The argument is on a single line and correctly quoted for the shell.
dfx deps init icp_ledger --argument "(variant { Init = record { minting_account = \"$(dfx ledger account-id)\"; initial_values = vec {}; send_whitelist = vec {}; transfer_fee = opt record { e8s = 10_000 : nat64; }; token_symbol = opt \"LICP\"; token_name = opt \"Local ICP\"; } })"
echo "   ICP Ledger initialized."

echo "8. Deploying dependencies (Internet Identity and ICP Ledger)..."
#
dfx deps deploy
echo "   Dependencies deployed."

echo "9. Deploying the main backend canister (main.mo)..."
#
dfx deploy backend
echo "   Backend deployed."

echo "10. Navigating to the frontend directory to build the web application..."
#
cd src/frontend
echo "    Changed to frontend directory: $(pwd)"

echo "11. Installing Node.js dependencies for the frontend..."
#
npm install
echo "    Frontend dependencies installed."

echo "12. Building the frontend application for production..."
#
npm run build
echo "    Frontend application built."

echo "--------------------------------------------------------"
echo "Infinity Task Protocol local deployment process completed successfully."
echo "The Dapp should now be accessible via DFX's local port."
echo "You can stop DFX anytime using the 'dfx stop' command from the project root."
echo "--------------------------------------------------------"
