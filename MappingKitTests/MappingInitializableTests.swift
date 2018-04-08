//
//  MappingInitializableTests.swift
//  MappingKitTests
//
//  Created by Clément NONN on 08/04/2018.
//  Copyright © 2018 Clément NONN. All rights reserved.
//

import XCTest
@testable import MappingKit

class MappingInitializableTests: XCTestCase {
    struct DestinationTest {
        var test: Int
    }

    func testInit() {
        let mapper = BaseMapper(table: [
            BaseMapping(sourcePath: \String.count, destinationPath: \DestinationTest.test),
        ])
        
        do {
            let dest = try DestinationTest(from: mapper, with: "TestString")
            XCTAssertEqual(dest.test, "TestString".count)
        } catch {
            XCTFail("error occured : \(error)")
        }
    }
}

extension MappingInitializableTests.DestinationTest: MappingInitializable {
    typealias T = String
    
    init(from mapping: BaseMapper<String, MappingInitializableTests.DestinationTest>, with value: String) throws {
        guard let firstMapping = mapping.table.filter({ $0.destinationPath == \MappingInitializableTests.DestinationTest.test }).first else {
            throw MappingError.invalidKeyPath(\MappingInitializableTests.DestinationTest.test)
        }
        
        self.test = try firstMapping.value(from: value)
    }
}

