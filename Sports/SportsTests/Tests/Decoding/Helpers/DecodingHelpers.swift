//
//  DecodingHelpers.swift
//  SportsTests
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation
import XCTest

protocol DecodingTestable: AnyObject {
    var data: Data! { get set }
}

extension DecodingTestable where Self: XCTestCase {
    func makeData(with json: String) {
        guard let data = json.data(using: .utf8) else {
            XCTAssert(false, "Failed to create data from the JSON mock.")
            return
        }
        self.data = data
    }
}
