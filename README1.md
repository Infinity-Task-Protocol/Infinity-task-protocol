Deploy instructions:

git clone https://github.com/Infinity-Task-Protocol/Infinity-task-protocol.git
cd Infinity-task-protocol

dfx start --clean --background
dfx generate backend

dfx deps pull
dfx deps init internet_identity
dfx deps init icp_ledger --argument "(variant { 
    Init = record {
        minting_account = \"$(dfx ledger account-id)\";
        initial_values = vec {};
        send_whitelist = vec {};
        transfer_fee = opt record { e8s = 10_000 : nat64; };
        token_symbol = opt \"LICP\";
        token_name = opt \"Local ICP\"; 
    }
})"
dfx deps deploy

dfx deploy backend

cd src/frontend
npm install
npm run build
