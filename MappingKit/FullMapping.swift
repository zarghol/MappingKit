//
//  FullMapping.swift
//  MappingKit
//
//  Created by Clément NONN on 08/04/2018.
//  Copyright © 2018 Clément NONN. All rights reserved.
//

import Foundation

struct FullMapping<Source, Destination, Value> {
    let sourcePath: KeyPath<Source, Value>
    let destinationPath: WritableKeyPath<Destination, Value>
    
    init(sourcePath: KeyPath<Source, Value>, destinationPath: WritableKeyPath<Destination, Value>) {
        self.sourcePath = sourcePath
        self.destinationPath = destinationPath
    }
    
    // method signature match the BaseMapping use signature
    func use(_ source: Source, _ destination: Destination) -> Destination {
        var dest = destination
        dest[keyPath: destinationPath] = source[keyPath: sourcePath]
        return dest
    }
}
