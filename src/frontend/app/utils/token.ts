export function toBigIntAmount(value: string, decimals: number): bigint {
    const [intPart = "0", decimalPart = ""] = value.split(".")
    const amountString = intPart + decimalPart.padEnd(decimals, "0")
    return BigInt(amountString)
}
