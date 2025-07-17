echo "🛑 Stopping dfx if it's running..."
dfx stop

echo "🚀 Starting dfx with clean state..."
dfx start --clean --background

echo "🔐 Checking and creating base identities..."
dfx identity list | grep -q "^0000Deployer$" || dfx identity new 0000Deployer
dfx identity list | grep -q "^minter$" || dfx identity new minter

echo "👤 Creating Freelancer identities..."
dfx identity list | grep -q "^0000Freelancer$" || dfx identity new 0000Freelancer
dfx identity use 0000Freelancer
export Freelancer0=$(dfx identity get-principal)

dfx identity list | grep -q "^0001Freelancer$" || dfx identity new 0001Freelancer
dfx identity use 0001Freelancer
export Freelancer1=$(dfx identity get-principal)

dfx identity list | grep -q "^0002Freelancer$" || dfx identity new 0002Freelancer
dfx identity use 0002Freelancer
export Freelancer2=$(dfx identity get-principal)

echo "👤 Creating Task Owner identities..."
dfx identity list | grep -q "^0000TaskOwner$" || dfx identity new 0000TaskOwner
dfx identity use 0000TaskOwner
export TaskOwner0=$(dfx identity get-principal)

dfx identity list | grep -q "^0001TaskOwner$" || dfx identity new 0001TaskOwner
dfx identity use 0001TaskOwner
export TaskOwner1=$(dfx identity get-principal)

dfx identity list | grep -q "^0002TaskOwner$" || dfx identity new 0002TaskOwner
dfx identity use 0002TaskOwner
export TaskOwner2=$(dfx identity get-principal)

dfx identity list | grep -q "^0003TaskOwner$" || dfx identity new 0003TaskOwner
dfx identity use 0003TaskOwner
export TaskOwner3=$(dfx identity get-principal)

echo "🔁 Switching back to deployer identity..."
dfx identity use 0000Deployer

echo "📦 Pulling dependencies and deploying ICP Ledger..."
dfx deps pull
dfx deps init internet_identity
dfx deps init icp_ledger --argument "(variant { 
    Init = record {
        minting_account = \"$(dfx --identity minter ledger account-id)\";
        initial_values = vec {};
        send_whitelist = vec {};
        transfer_fee = opt record { e8s = 10_000 : nat64; };
        token_symbol = opt \"LICP\";
        token_name = opt \"Local ICP\"; 
    }
})"

dfx deps deploy

echo "🚧 Deploying backend and treasury canisters..."
dfx deploy backend
dfx deploy treasury --argument "(record {mainPlatform = principal \"$(dfx canister id backend)\"})"
dfx canister call backend setTreasuryCanisterId "(principal \"$(dfx canister id treasury)\")"

echo "💸 Sending initial ICP to Task Owners..."
dfx identity use minter

dfx canister call icp_ledger icrc1_transfer "(
  record {
    to = record {
      owner = principal \"${TaskOwner0}\";
      subaccount = null;
    };
    fee = null;
    memo = null;
    from_subaccount = null;
    created_at_time = null;
    amount = 5_000_000_000 : nat;
  },
)"

dfx canister call icp_ledger icrc1_transfer "(
  record {
    to = record {
      owner = principal \"${TaskOwner1}\";
      subaccount = null;
    };
    fee = null;
    memo = null;
    from_subaccount = null;
    created_at_time = null;
    amount = 10_000_000_000 : nat;
  },
)"

dfx canister call icp_ledger icrc1_transfer "(
  record {
    to = record {
      owner = principal \"${TaskOwner2}\";
      subaccount = null;
    };
    fee = null;
    memo = null;
    from_subaccount = null;
    created_at_time = null;
    amount = 7_000_000_000 : nat;
  },
)"

echo "📝 TaskOwner0 signs up and creates a task..."
dfx identity use 0000TaskOwner
dfx canister call backend signUp '(record {name = "TaskOwner0"})'
dfx canister call backend createTask '(record {
    title = "Test Task 1";
    assets = vec {};
    description = "Description test task 1";
    keywords = vec { "Test"; "Motoko" };
    rewardRange = record { 500000000 : nat; 1000000000 : nat };
    token = "ICP"
})'

echo "🧪 Freelancer0 signs up, verifies, and applies for the task..."
dfx identity use 0000Freelancer
dfx canister call backend signUp '(record {name = "0001Freelancer"})'
code_output=$(dfx canister call backend getVerificationCode)
code=$(echo "$code_output" | sed -n 's/.*opt (\([0-9_]*\).*/\1/p' | tr -d '_')
dfx canister call backend enterCodeVerification $code
dfx canister call backend applyForTask '(record { taskId = 1; amount = 750000000 })'

echo "🧪 Freelancer1 signs up, verifies, and applies for the task..."
dfx identity use 0001Freelancer
dfx canister call backend signUp '(record {name = "0002Freelancer"})'
code_output=$(dfx canister call backend getVerificationCode)
code=$(echo "$code_output" | sed -n 's/.*opt (\([0-9_]*\).*/\1/p' | tr -d '_')
dfx canister call backend enterCodeVerification $code
dfx canister call backend applyForTask '(record { taskId = 1; amount = 600000000 })'

echo "✅ TaskOwner0 accepts the offer from Freelancer1..."
dfx identity use 0000TaskOwner
dfx canister call backend acceptOffer "(1, principal \"${Freelancer1}\")"


output=$(dfx canister call backend getTransferArgForTask 1)

# Paso 1: eliminar la primera y última línea
trimmed=$(echo "$output" | sed '1d;$d')

# Paso 2: eliminar la palabra "opt" y la coma final si está en esa línea
cleaned=$(echo "$trimmed" | sed 's/^[[:space:]]*opt[[:space:]]*//; s/,[[:space:]]*$//')

blockIndex=$(dfx canister call icp_ledger icrc1_transfer "($cleaned)" | sed -n 's/.*Ok = \([0-9_]*\) :.*/\1/p')

dfx canister call backend paymentNotification "(
  1 : nat,
  $blockIndex : nat64,
  $cleaned,
  principal \"ryjl3-tyaaa-aaaaa-aaaba-cai\",
)"

echo "✅ Freelancer1 delibery task to TaskOwner0 ..."
dfx identity use 0001Freelancer
dfx canister call backend deliveryTask "(record {
  _msg = \"Delivery Task Title\";
  file = record {
    id = 0 : nat;
    data = blob \"\00\00\00\";
    mimeType = \"text\";
    withAccess = vec {};
  };
  taskId = 1 : nat;
})"

echo "✅ TaskOwner0 accept the task delivery from Freelancer1..."
dfx identity use 0000TaskOwner
dfx canister call backend acceptDelivery "(record { 
  review = \"Text Review\"; 
  taskId = 1 : nat; 
  qualification = 10 : nat8 
})"

dfx identity use 0001Freelancer

# balance =  600_000_000 - 10_000_000 - 5.6% of 600_000_000 = 556_400_000
expected_output='(
  opt vec {
    record {
      token = principal "ryjl3-tyaaa-aaaaa-aaaba-cai";
      balance = 556_400_000 : nat;
    };
  },
)'
actual_output=$(dfx canister call treasury getMyBalances)
if [ "$actual_output" == "$expected_output" ]; then
  echo "✅ Test passed"
else
  echo "❌ Test failed"
fi
account="(record {owner=principal \"$(dfx identity get-principal)\"; subaccount=null})"

dfx canister call treasury withdrawal "(record {token = principal \"ryjl3-tyaaa-aaaaa-aaaba-cai\"; amount = 400_000_000; to = $account})"

expected_output='(
  opt vec {
    record {
      token = principal "ryjl3-tyaaa-aaaaa-aaaba-cai";
      balance = 156_390_000 : nat;
    };
  },
)'
actual_output=$(dfx canister call treasury getMyBalances)
if [ "$actual_output" == "$expected_output" ]; then
  echo "✅ Test passed"
else
  echo "❌ Test failed"
fi

expectedBalance="4.00000000 ICP"
balance=$(dfx ledger balance)
if [[ $balance ==  $expectedBalance ]]; then
  echo "✅ Test passed"
else
  echo "❌ Test failed"
  echo $balance
  echo $expectedBalance
fi

dfx canister call treasury withdrawal "(record {token = principal \"ryjl3-tyaaa-aaaaa-aaaba-cai\"; amount = 156_380_000; to = $account})"

expectedBalance="5.56380000 ICP" 
balance=$(dfx ledger balance)
if [[ $balance ==  $expectedBalance ]]; then
  echo "✅ Test passed"
else
  echo "❌ Test failed"
  echo $balance
  echo $expectedBalance
fi