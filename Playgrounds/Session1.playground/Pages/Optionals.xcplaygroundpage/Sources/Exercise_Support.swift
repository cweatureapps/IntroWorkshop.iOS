import Foundation

public struct Transaction {
    public let id:String
    public let description:String
    public let amount:Double
}

public struct Account {
    public let accountName:String
    public let accountNumber:String
    public let availableBalance:Double
    public let balance:Double
    public let transactions:[Transaction]?
    public let atmID:String?
}

public func dummyAccount() -> Account {
    return Account(accountName: "MyAccount", accountNumber: "123456789", availableBalance: 10.00, balance: 200.00, transactions: nil, atmID: nil)
}

public func dummyAccount2() -> Account {
    let transactions = [
        Transaction(id: "7ecc19e1a0be36ba2c6f05d06b5d3058", description: "Wdl ATM CBA ATM TOWN HALL SQUARE NSW 253432 AUS", amount: 200.0),
        Transaction(id: "b71bf065b640217dad602f86ac047722", description: "BPAY - Telstra mobile", amount: -49.0)
    ]
    return Account(accountName: "MyAccount", accountNumber: "123456789", availableBalance: 10.00, balance: 200.00, transactions: transactions, atmID: nil)
}