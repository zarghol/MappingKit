//
//  Updatable.swift
//  MappingKit
//
//  Created by Clément NONN on 08/04/2018.
//  Copyright © 2018 Clément NONN. All rights reserved.
//

import Foundation

protocol Updatable {
    mutating func modify<Source, Type>(with mapping: BaseMapping<Source, Self>, from source: Source) -> Type?
}

extension Updatable {
    mutating func modify<Source, Type>(with mapping: BaseMapping<Source, Self>, from source: Source) -> Type? {
        guard let destPath = mapping.destinationPath as? WritableKeyPath<Self, Type> else {
            return nil
        }
        guard let sourcePath = mapping.sourcePath as? KeyPath<Source, Type> else {
            return nil
        }
        let val: Type = source[keyPath: sourcePath]
        self[keyPath: destPath] = val
        return self[keyPath: destPath]
    }
}


// TODO: remove Type from generic parameters (use of mapping.type ?)
