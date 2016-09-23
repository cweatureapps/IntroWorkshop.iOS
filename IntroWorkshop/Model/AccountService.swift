//
//  AccountService.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 18/01/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import Foundation

class AccountService {
    private var serviceHelper: ServiceHelper

    // FIXME: Change this so that you can use constructor DI, passing through a StubServiceHelper when calling from the unit test
    // See also `ServiceHelperFactory` which has a factory method for creating the correct ServiceHelper
    init() {
        serviceHelper = NetworkServiceHelper()
    }

    // FIXME: Define a completion closure, which can be called to pass back a Result enum
//    func getAccounts(completion: /* FIXME */) {
//    }

}
