import Ledger "../interfaces/ICP_Token/ledger_icp";
import Nat64 "mo:base/Nat64";
import Principal "mo:base/Principal";
import Nat8 "mo:base/Nat8";
import Int "mo:base/Int";
import Blob "mo:base/Blob";
import Debug "mo:base/Debug";
import Buffer "mo:base/Buffer";
import Array "mo:base/Array";


module {
    type AcceptOfferResponse = {
        #ICP: Ledger.TransferArgs;
        #ICRC2: Ledger.TransferArg;
        #Err: Text
    };

    public func blobToNat64(b : ?Blob) : Nat64 {
        var n : Nat64 = 0;
        switch (b){
            case ( ?b ){
                for (byte in Blob.toArray(b).vals()) {
                    n := (n * 256) + Nat64.fromNat(Nat8.toNat(byte));
                };
            };
            case null {};
        };
        n
    };

    public func nat64ToBlob(n : Nat64) : Blob {
        var num = n;
        let buf = Buffer.Buffer<Nat8>(8); // hasta 8 bytes para un Nat64

        // extraemos los bytes en orden inverso (little-endian)
        while (num > 0) {
            let byte : Nat8 = Nat8.fromNat(Nat64.toNat(num % 256));
            buf.add(byte);
            num := num / 256;
        };

        if (buf.size() == 0) {
            buf.add(0);
        };

        // ahora invertimos el buffer para obtener big-endian
        let arr = Buffer.toArray(buf);
        let arrBE = Array.tabulate<Nat8>(arr.size(), func(i) {
            arr[arr.size() - 1 - i]
        });

        Blob.fromArray(arrBE)
    };

    public func equalArgs(a1: Ledger.TransferArg, a2: Ledger.TransferArgs): Bool {
        let equalAmount = a1.amount == Nat64.toNat(a2.amount.e8s);
        let equalTo = Principal.toLedgerAccount((a1.to.owner, a1.to.subaccount)) == a2.to;
        let equalFromSubaccount = a1.from_subaccount == a2.from_subaccount;
        let equalMemo = blobToNat64(a1.memo) == a2.memo;
        return equalAmount and equalTo and equalFromSubaccount and equalMemo
    };

    public func unWarpArgs(wrapedArgs: AcceptOfferResponse): Ledger.TransferArg {
        switch wrapedArgs {
            case ( #ICP(args) ) {
                let created_at_time: ?Nat64 = switch (args.created_at_time) {
                    case null { null };
                    case ( ?val ) {
                        ?val.timestamp_nanos
                    }
                };
                {
                    amount : Nat = Nat64.toNat(args.amount.e8s);
                    created_at_time;
                    fee : ?Nat = ?Nat64.toNat(args.fee.e8s);
                    from_subaccount : ?Blob = args.from_subaccount;
                    memo : ?Blob = ?nat64ToBlob(args.memo);
                    to = {owner = Principal.fromText("aaaaa-aa"); subaccount = null} // TODO
                }
            };
            case ( #ICRC2(args) ){
                args
            };
            case ( #Err(_)) {
                Debug.trap("Error tansaction rgs")
            }
        }

    }
}