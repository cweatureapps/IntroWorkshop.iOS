//
//  TransactionModelTests.swift
//  IntroWorkshopTests
//
//  Created by Ken Ko on 27/03/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import XCTest
@testable import IntroWorkshop

class TransactionModelTests: XCTestCase {

    // MARK: Unit testing date helpers

    /// Gets the Date for the given date string of the format "dd/MM/yyyy"
    private func getDate(from: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.date(from: from)!
    }

    /// Asserts that the Date matches the tiven day, month and year
    private func assertDate(_ date: Date, _ day: Int, _ month: Int, _ year: Int) {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: date)
        XCTAssertEqual(components.day, day, "day did not match")
        XCTAssertEqual(components.month, month, "month did not match")
        XCTAssertEqual(components.year, year, "year did not match")
    }

    // MARK: Tests

    func testServiceGetTransactions() {
        let exp = expectation(description: #function)
        let transactionService = TransactionService(serviceHelper: StubServiceHelper())
        let account = Account(id: "2423", accountName: "a", accountNumber: "1", availableFunds: 0, accountBalance: 0)
        transactionService.getTransactions(account: account) { result in
            switch result {
            case .success(let transactions):
                XCTAssertEqual(transactions.count, 15)
                if let firstTransaction = transactions.first {
                    XCTAssertEqual(firstTransaction.id, "44e5b2bc484331ea24afd85ecfb212c8")
                    self.assertDate(firstTransaction.date, 20, 12, 2015)
                    XCTAssertEqual(firstTransaction.transactionDescription, "Kaching TFR from JOHN CITIZEN\nxmas donation")
                    XCTAssertEqual(firstTransaction.amount, 12.00)
                    XCTAssertFalse(firstTransaction.isPending)
                    XCTAssertEqual(firstTransaction.formattedDate, "Sun 20 Dec 2015")
                }
                if let lastTransaction = transactions.last {
                    XCTAssertEqual(lastTransaction.id, "901889f4f34f8ca18ac2f53d1fed346e")
                    self.assertDate(lastTransaction.date, 19, 12, 2015)
                    XCTAssertEqual(lastTransaction.transactionDescription, "PENDING: CITYOFSYDNEYPARKINGTX SYDNEY, 1215\nLAST 4 CARD DIGITS: 6901")
                    XCTAssertEqual(lastTransaction.amount, -8.00)
                    XCTAssertTrue(lastTransaction.isPending)
                    XCTAssertEqual(lastTransaction.formattedDate, "Sat 19 Dec 2015")
                }
            case .failure(let error):
                let nsError = error as NSError
                XCTFail("error occurred: \(nsError.localizedDescription)")
            }
            
            exp.fulfill()   // this tells the test the async is complete
        }
        waitForExpectations(timeout: 1) { error in
            guard let error = error else { return }
            XCTFail(error.localizedDescription)
        }
    }

    func testDaysAgo() {
        let transaction = Transaction(id: "", date: getDate(from: "20/12/2015"), transactionDescription: "", amount: 0, isPending: false)
        XCTAssertEqual(transaction.daysAgo(today: getDate(from: "20/12/2015")), "Today")
        XCTAssertEqual(transaction.daysAgo(today: getDate(from: "21/12/2015")), "Yesterday")
        XCTAssertEqual(transaction.daysAgo(today: getDate(from: "22/12/2015")), "2 days ago")
        XCTAssertEqual(transaction.daysAgo(today: getDate(from: "23/12/2015")), "3 days ago")
    }

    func testManagerGetTransactions() {
        let exp = expectation(description: #function)
        let accountService = AccountService(serviceHelper: StubServiceHelper())
        let transactionService = TransactionService(serviceHelper: StubServiceHelper())
        let manager = AccountsManager(accountService: accountService, transactionService: transactionService)
        let account = Account(id: "2423", accountName: "a", accountNumber: "1", availableFunds: 0, accountBalance: 0)
        manager.getTransactions(account: account) { result in

            switch result {
            case .success(let transactionGroups):

                XCTAssertEqual(transactionGroups.count, 9)
                if let firstGroup = transactionGroups.first {
                    self.assertDate(firstGroup.date, 20, 12, 2015)

                    XCTAssertEqual(firstGroup.transactions.count, 3)
                    if firstGroup.transactions.count == 3 {

                        let firstTransaction = firstGroup.transactions.first!
                        XCTAssertTrue(firstTransaction.isPending)
                        XCTAssertTrue(firstTransaction.transactionDescription.contains("PENDING: WILSON PARKING"))

                        let secondTransaction = firstGroup.transactions[1]
                        XCTAssertFalse(secondTransaction.isPending)
                        XCTAssertEqual(secondTransaction.transactionDescription, "Kaching TFR from JOHN CITIZEN\nxmas donation")
                    }
                }

            case .failure(let error):
                let nsError = error as NSError
                XCTFail("error occurred: \(nsError.localizedDescription)")
            }

            exp.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            guard let error = error else { return }
            XCTFail(error.localizedDescription)
        }
    }


}
