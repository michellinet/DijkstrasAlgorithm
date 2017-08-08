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

class Path {
    var total: Int!
    var destination: Node
    var previous: Path!
    
    init(){
        destination = Node()
    }
}
