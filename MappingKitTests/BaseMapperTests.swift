//
//  BaseMapperTests.swift
//  MappingKitTests
//
//  Created by Clément NONN on 08/04/2018.
//  Copyright © 2018 Clément NONN. All rights reserved.
//

import XCTest
@testable import MappingKit

class BaseMapperTests: XCTestCase {
    struct DestinationTest {
        var test: Int
        var test2: String
    }
    
    func testUse() {
        var destination = DestinationTest(test: 42, test2: "Test")
        XCTAssertEqual(destination.test, 42)
        XCTAssertEqual(destination.test2, "Test")
        
        let mapper = BaseMapper(table: [
            BaseMapping(sourcePath: \String.count, destinationPath: \DestinationTest.test),
            BaseMapping(sourcePath: \String.capitalized, destinationPath: \DestinationTest.test2)
        ])
        
        let source = "the cake is a lie"
        destination = mapper.use(from: source, to: destination)
        
        XCTAssertEqual(destination.test, source.count)
        XCTAssertEqual(destination.test2, source.capitalized)
    }
    
}
