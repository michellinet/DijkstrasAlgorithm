//
//  Vertex.swift
//  Dijkstra
//
//  Created by Michelline Tran on 7/14/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import Foundation

struct Vertex: CustomStringConvertible {
    var key: String
    var neighbors: Array<Edge>
    
    var description: String {
        return key
    }
}

extension Vertex: Equatable {
    static func ==(lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.key == rhs.key
    }
}
