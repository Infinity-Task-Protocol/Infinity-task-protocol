Deploy instructions:

git clone https://github.com/Infinity-Task-Protocol/Infinity-task-protocol.git
cd Infinity-task-protocol

dfx start --clean --background
dfx generate backend

dfx deps pull
// dfx deps init
dfx deps deploy

dfx deploy backend

cd src/frontend
npm install
npm run build
