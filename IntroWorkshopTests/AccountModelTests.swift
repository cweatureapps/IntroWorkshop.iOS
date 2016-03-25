//
//  AccountModelTests.swift
//  IntroWorkshopTests
//
//  Created by Ken Ko on 3/12/2015.
//  Copyright © 2015 Commonwealth Bank of Australia. All rights reserved.
//

import XCTest
@testable import IntroWorkshop

class AccountModelTests: XCTestCase {

    func testThatMaskedAccountNumberIsCorrect() {
        let account = Account(id: "1", accountName: "a", accountNumber: "12347890", availableFunds: 12.34, accountBalance: 34.56)
        XCTAssertEqual(account.maskedAccountNumber, "XXXX7890")
    }

    func testThatMaskedAccountNumberForShortNumberIsUnchanged() {
        let account = Account(id: "1", accountName: "a", accountNumber: "1234", availableFunds: 12.34, accountBalance: 34.56)
        XCTAssertEqual(account.maskedAccountNumber, "1234")
    }

    func testThatAccountParsingIsCorrect() {
        let json: JSON = [
            "id": "1000",
            "accountName": "a",
            "accountNumber": "123",
            "availableFunds": 12.34,
            "accountBalance": 34.56
        ]
        let account = Account(json: json)!
        XCTAssertEqual(account.id, "1000")
        XCTAssertEqual(account.accountName, "a")
        XCTAssertEqual(account.accountNumber, "123")
        XCTAssertEqual(account.availableFunds, 12.34)
        XCTAssertEqual(account.accountBalance, 34.56)
    }

    func testThatBadJsonReturnsNil() {
        let json: JSON = [
            "id": "1234",
            "accountNameX": "a",
            "accountNumber": "123",
            "availableFunds": 12.34,
            "accountBalance": 34.56
        ]
        let account = Account(json: json)
        XCTAssertNil(account)
    }

    func testAccountListFromJson() {
        let rawAccount: JSON = [
            "id": "1000",
            "accountName": "a",
            "accountNumber": "123",
            "availableFunds": 12.34,
            "accountBalance": 34.56
        ]
        let json: JSON = ["accounts": [rawAccount]]
        let accounts = Account.accountList(json: json)
        XCTAssertEqual(accounts.count, 1)
        if let account = accounts.first {
            XCTAssertEqual(account.id, "1000")
            XCTAssertEqual(account.accountName, "a")
            XCTAssertEqual(account.accountNumber, "123")
            XCTAssertEqual(account.availableFunds, 12.34)
            XCTAssertEqual(account.accountBalance, 34.56)
        }
    }

    func testGetAccounts() {
        let exp = expectation(description: "testGetAccounts")

        // Use constructor DI to create a service which uses the StubServiceHelper
        let service = AccountService(serviceHelper: StubServiceHelper())

        // call account service
        service.getAccounts { result in

            // put asserts here
            switch result {
            case .success(let accounts):
                XCTAssertEqual(accounts.count, 2)
                let account = accounts.first!
                XCTAssertEqual(account.id, "2423")
                XCTAssertEqual(account.accountName, "Complete Access")
                XCTAssertEqual(account.accountNumber, "602-000 6412 3154")
                XCTAssertEqual(account.availableFunds, 3456.75)
                XCTAssertEqual(account.accountBalance, 4456.75)
            case .failure:
                XCTFail("error occurred")
            }

            exp.fulfill()   // this tells the test the async is complete
        }

        // if async call doesn't run, fail the test
        waitForExpectations(timeout: 5) { error in
            guard let error = error else { return }
            XCTFail(error.localizedDescription)
        }
    }

    func testNumberFormatting() {
        let account = Account(id: "111", accountName: "foo", accountNumber: "1234", availableFunds: 123.45, accountBalance: 5678.9)
        XCTAssertEqual(account.formattedAvailableFunds, "$123.45")
        XCTAssertEqual(account.formattedAccountBalance, "$5,678.90")
    }
}
