//
//  BaseMapper.swift
//  MappingKit
//
//  Created by Clément NONN on 08/04/2018.
//  Copyright © 2018 Clément NONN. All rights reserved.
//

import Foundation

struct BaseMapper<Source, Destination> {
    var table: [BaseMapping<Source, Destination>]
    
    func use(from source: Source, to destination: Destination) -> Destination {
        var dest = destination
        for mapping in table {
            dest = mapping.use(source, dest)
        }
        
        return dest
    }
}
