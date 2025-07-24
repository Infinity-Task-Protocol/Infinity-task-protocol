#### [◄ Back](./README.md)


<img width="1308" height="716" alt="image" src="https://github.com/user-attachments/assets/be81354c-19c0-4aba-afb3-fa88243f8ec3" />


### Stage 0: Previous State

**Main Modules:**  
- Motoko Core Backend  
- Vite React Frontend

**Features**

- **User Module (Backend):**
  - User registration and login

- **Task Manager Module:**
  - Create task  
  - Read task  
  - Update and configure task  
  - Delete task

- **Task Assignment Flow:**
  - Place a bid  
  - View bids on own tasks  
  - Accept a specific bid

- **Task Delivery and Acceptance Flow:**
  - Submit task delivery  
  - Persist source files associated with delivery  
  - Accept delivery

---

### Stage 1: Classification Round

**Main Modules:**  
- Treasury Canister (new in this stage)  
- Main Canister  
- Frontend

**Features**

- **Enhancements to Existing Flows & Structure:**

  - **Notifications:**

    | Notification Kind | Trigger Action                            | Receiver     |
    |-------------------|--------------------------------------------|--------------|
    | New bid on task   | Freelancer places a bid                   | Task owner   |
    | Bid accepted      | Task owner accepts an offer               | Freelancer   |
    | Task delivered    | Freelancer delivers the completed task    | Task owner   |
    | Delivery accepted | Task owner approves the delivery          | Freelancer   |

  - Display user notifications upon login, page reload, or via polling from frontend  
  - Refactor task structure to support multimedia attachments  
  - Task owner can access the delivery submitted by the freelancer

- **Task Assignment & Payment Integration:**
  - Payment from task owner to Treasury Canister  
  - Lock funds in Treasury Canister until task is approved  
  - Release funds to freelancer's internal balance upon delivery approval  
  - Display internal balances for supported tokens (ICRC-1 / ICRC-2), queried automatically after login

- **Withdrawal Flow:**
  - User can request withdrawal to a specified account  
  - Inter-canister communication between Treasury and Ledger to transfer tokens

- **Treasury Administration Features:**
  - Add new supported ICRC-2 tokens  
  - Add admin accounts  
  - Prepare public registry of treasury operations and withdrawal activity

- **Frontend Enhancements:**
  - Renew frontend UI  
  - Add Plug Wallet support for transaction flow

---

### Stage 2: August

**Main Modules:**

- **Chat Canister:**
  - Support private messaging between users  
  - Context-aware chat: Private but auditable conversations per task  
  - Group chat support  
  - Optional end-to-end encryption  
  - Inbox with message notifications

- **Email Notifications:**
  - Complete user email verification flow by sending a **verification code**  
  - Enhance notification system with email alerts for key events (new offer, offer accepted, etc.)

- **Task Delivery Restructure:**
  - Support for **partial deliveries** and **milestone-based delivery** flow  
  - Design structure for long-running tasks with deliverable checkpoints

- **Skills Certifier (Initial Version):**
  - Canister to manage skills certification programs  
  - Scalable and reusable design to support multiple certifying entities (SaaS-ready)  
  - Integrate with Treasury Canister for certification program fee management

---

### Stage 3: September

- **Skills Certifier Expansion:**
  - Support for generating non-transferable ICRC-7 / ICRC-37 NFTs for certifications  
  - Manage treasury flows from certification activities via Treasury Canister.
- Brainstorming
