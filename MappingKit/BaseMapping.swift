//
//  BaseMapping.swift
//  MappingKit
//
//  Created by Clément NONN on 08/04/2018.
//  Copyright © 2018 Clément NONN. All rights reserved.
//

import Foundation

enum MappingError: Error {
    case invalidKeyPath(AnyKeyPath)
}

public struct BaseMapping<Source, Destination> {
    public let sourcePath: PartialKeyPath<Source>
    public let destinationPath: PartialKeyPath<Destination>
    public let type: Any.Type
    
    public let use: (Source, Destination) -> Destination
    
    public init<Value>(sourcePath: KeyPath<Source, Value>, destinationPath: WritableKeyPath<Destination, Value>) {
        self.sourcePath = sourcePath
        self.destinationPath = destinationPath
        self.type = Value.self
        
        self.use = { source, destination in
            var dest = destination
            dest[keyPath: destinationPath] = source[keyPath: sourcePath]
            return dest
        }
    }
}

extension BaseMapping {
    func value<T>(from source: Source) throws -> T {
        guard let keyPath = self.sourcePath as? KeyPath<Source, T> else {
            throw MappingError.invalidKeyPath(self.sourcePath)
        }
        return source[keyPath: keyPath]
    }
}

/*
 TODO: (if possible)
 - transform use in method (using type)
 - transform PartialKeyPath to KeyPath
 */
