//
//  Node.swift
//  Dijkstra
//
//  Created by Michelline Tran on 8/7/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import Foundation

class Node {
    var key: String?
    var neighbors: Array<OEdge>
    
    init() {
        self.neighbors = Array<OEdge>()
    }
}

class OEdge {
    var neighbor: Node
    var weight: Int
    
    init() {
        weight = 0
        self.neighbor = Node()
    }
}

//An object to track each node visit
class Path {
    //the total cumulative edge weight to reach a particular destination
    var total: Int!
    
    //the desired destination of the path
    var destination: Node
   
    //the previous Path taken to reach the current (starting) node
    var previous: Path?
    
    init(){
        destination = Node()
    }
}

extension Node: Equatable {
    static func ==(lhs: Node, rhs: Node) -> Bool {
        return lhs.key == rhs.key
    }
}

extension Path: Equatable {
    static func ==(lhs: Path, rhs: Path) -> Bool {
        var lhsPreviousPath = Path()
        var rhsPreviousPath = Path()
        if let lhsPrevious = lhs.previous, let rhsPrevious = rhs.previous {
            lhsPreviousPath = lhsPrevious
            rhsPreviousPath = rhsPrevious
        }
        
        return lhs.total == rhs.total && lhs.destination == rhs.destination && lhsPreviousPath == rhsPreviousPath
    }
}
