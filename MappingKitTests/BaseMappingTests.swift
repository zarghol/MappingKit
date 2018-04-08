//
//  BaseMappingTests.swift
//  MappingKitTests
//
//  Created by Clément NONN on 08/04/2018.
//  Copyright © 2018 Clément NONN. All rights reserved.
//

import XCTest
@testable import MappingKit

class BaseMappingTests: XCTestCase {
    struct DestinationTest {
        var test: String
    }

    func testUse() {
        var destination = DestinationTest(test: "Foo")
        XCTAssertEqual(destination.test, "Foo")
        
        let mapping = BaseMapping(sourcePath: \String.description, destinationPath: \DestinationTest.test)
        
        destination = mapping.use("Test", destination)
        XCTAssertEqual(destination.test, "Test")
    }
    
    func testValue() {
        let mapping = BaseMapping(sourcePath: \String.description, destinationPath: \DestinationTest.test)
        do {
            let description: String = try mapping.value(from: "TestString")
            
            XCTAssertEqual(description, "TestString".description)
        } catch {
            XCTFail("unable to get mapping value : \(error)")
        }
    }
    
    func testValueNotPass() {
        let mapping = BaseMapping(sourcePath: \String.description, destinationPath: \DestinationTest.test)
        do {
            let description: Int = try mapping.value(from: "TestString")
            
            XCTFail("try not work : \(description)")
        } catch MappingError.invalidKeyPath(let path) where path == \String.description {
        } catch {
            XCTFail("error not good : \(error)")
        }
    }
}
