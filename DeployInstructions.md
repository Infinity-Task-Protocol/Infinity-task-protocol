Deploy instructions:

```sh 
git clone https://github.com/Infinity-Task-Protocol/Infinity-task-protocol.git
cd Infinity-task-protoco
```
Replica initialice
```sh
dfx start --clean --background
```

Idenitity creation for ledger minter account
```sh
dfx identity list | grep -q "^minter$" || dfx identity new minter
```
Deploy dependencies

```sh
dfx deps pull
dfx deps init internet_identity
dfx deps init icp_ledger --argument "(variant { 
    Init = record {
        minting_account = \"$(dfx ledger account-id --identity minter)\";
        initial_values = vec {};
        send_whitelist = vec {};
        transfer_fee = opt record { e8s = 10_000 : nat64; };
        token_symbol = opt \"LICP\";
        token_name = opt \"Local ICP\"; 
    }
})"
dfx deps deploy
```

Candid generation
```sh
dfx generate backend
dfx generate treasury
```

Backend and Treasury Canister deploy
```sh
dfx deploy backend
dfx deploy treasury
```

SetTreasury reference in main canister
```sh
dfx canister call backend setTreasuryCanisterId "(principal \"$(dfx canister id treasury)\")"
```



Build and deploy frontend canister

```sh
cd src/frontend
npm install
npm run deploy
npm run build
npm run generate
dfx deploy frontend
```

Will continue ...
