//
//  Updatable.swift
//  MappingKit
//
//  Created by Clément NONN on 08/04/2018.
//  Copyright © 2018 Clément NONN. All rights reserved.
//

import Foundation

protocol Updatable {
    mutating func modify<Source, Type>(with mapping: BaseMapping<Source, Self>, from source: Source, type: Type.Type)
//    mutating func modify<Source, Type>(with mapping: BaseMapper<Source, Self>, from source: Source, type: Type.Type)
}

extension Updatable {
    mutating func modify<Source, Type>(with mapping: BaseMapping<Source, Self>, from source: Source, type: Type.Type) {
        let destPath = mapping.destinationPath as! WritableKeyPath<Self, Type> // enforce as! instead of guard because can't fail
        let sourcePath = mapping.sourcePath as! KeyPath<Source, Type> // enforce as! instead of guard because can't fail
        
        let val: Type = source[keyPath: sourcePath]
        self[keyPath: destPath] = val
    }
    
//    mutating func modify<Source>(with mapping: BaseMapper<Source, Self>, from source: Source) {
//        for map in mapping.table {
//            self.modify(with: map, from: source, type: map.type)
//        }
//    }
}


// TODO: remove Type from generic parameters (use of mapping.type ?)
