//
//  Result.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 23/09/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import Foundation

enum Result<T, Error: Swift.Error> {
    case success(T)
    case failure(Error)
}
