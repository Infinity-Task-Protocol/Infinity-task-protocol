# ♾ Infinity Task Protocol — Fully On-Chain Freelance Service Platform on ICP

**Infinity Task Protocol** is a fully on-chain platform built on the Internet Computer (ICP), designed to facilitate freelance service exchange between clients and workers with ultra-low fees, instant payouts, and full transparency.

---

## 🚨 The Problem

Traditional freelance platforms like Upwork or Fiverr suffer from:

- **Excessive commission rates**: Total effective fees often range from **20% to 40%** when including both platform charges and payment processing cuts.
- **Holding periods**: Freelancers frequently face **delays before receiving their earnings**.
- **High withdrawal costs**, especially in underbanked regions or when converting currencies.

---

## 💡 Our Solution

**Infinity Task Protocol** offers:

- **Fair commissions between 5% and 12%**, all-in.
- **No holding periods**: freelancers get paid instantly upon approval.
- **Crypto-native payments** via ICP tokens.
- **Fully on-chain logic**, built into smart contracts (canisters) on the Internet Computer.

---

## 🔁 How It Works

1. **Task Publishing:**  
   A client publishes a task, including a **description and a price range**.

2. **Freelancer Offers:**  
   Freelancers can submit offers with their proposed fee **within the specified range**. All offers are linked to the task.

3. **Offer Acceptance:**  
   The client accepts the most convenient offer. The system then generates the parameters to **sign a transaction via Plug Wallet**.

4. **Payment to Canister Subaccount:**  
   The backend prepares the transaction arguments, and the user sends ICP tokens to a **dedicated subaccount owned by the treasury canister**.

5. **Transaction Confirmation:**  
   The frontend sends back the **block index** of the transaction.  
   The backend then **verifies that the block contains the transaction**, using fields like `memo`, receiver, and amount.

6. **Escrow Creation:**  
   Once verified, the backend creates an **internal escrow** in favor of the freelancer.

7. **Work Delivery:**  
   The freelancer submits the task. The client **reviews and approves** the delivery.

8. **Funds Release:**  
   Upon approval, the escrow is **released and credited** to the freelancer’s internal balance.

9. **Withdrawal:**  
   Freelancers can **withdraw their earnings** at any time to:
   - A **self-custody wallet**, or
   - Any **CEX that supports the ICP network**.

---

## 🌐 Live Dapp

> ✅ **[Launch App on ICP Mainnet](https://grkfk-5iaaa-aaaak-quh7a-cai.icp0.io/)**  
> 🔐 **Backend Canister ID: [gyjow-laaaa-aaaak-quh6q-cai](https://a4gq6-oaaaa-aaaab-qaa4q-cai.raw.icp0.io/?id=gyjow-laaaa-aaaak-quh6q-cai)**

---

## 📹 Demo Video

🎥 Code and architecture walkthrough with voiceover:  
**[Watch the demo here](https://your-demo-link.com)**

---

## 📄 Documentation

### 🔧 Local Development

1. Clone the repository:
   ```bash
   git clone https://github.com/youruser/infinity-task-protocol.git
   cd infinity-task-protocol
