//
//  UpdatableTests.swift
//  MappingKitTests
//
//  Created by Clément NONN on 08/04/2018.
//  Copyright © 2018 Clément NONN. All rights reserved.
//

import XCTest
@testable import MappingKit

class UpdatableTests: XCTestCase {
    struct DestinationTest: Updatable {
        var test: Int
    }
    
    func testModify() {
        var destination = DestinationTest(test: 42)
        XCTAssertEqual(destination.test, 42)
        
        let mapping = BaseMapping(sourcePath: \String.count, destinationPath: \DestinationTest.test)
        
        let _: Int? = destination.modify(with: mapping, from: "Test")
        XCTAssertEqual(destination.test, "Test".count)
    }
}
