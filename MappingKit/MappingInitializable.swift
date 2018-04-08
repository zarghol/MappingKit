//
//  MappingInitializable.swift
//  MappingKit
//
//  Created by Clément NONN on 08/04/2018.
//  Copyright © 2018 Clément NONN. All rights reserved.
//

import Foundation

protocol MappingInitializable {
    associatedtype T
    init(from mapping: BaseMapper<T, Self>, with value: T) throws
}
