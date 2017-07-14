//
//  Graph.swift
//  Dijkstra
//
//  Created by Michelline Tran on 7/14/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import Foundation

struct Graph {
    var vertices: Array<Vertex>
    
    func processDijkstra(source: String,to endingDestination: String) -> [Vertex] {
        var shortestPath = [Vertex]()
        
        let startingVertex = vertices.first { (vertex) -> Bool in
            vertex.key == source
        }
        
        guard let startVertex = startingVertex else {
            return shortestPath
        }
        shortestPath.append(startVertex)
        
        var vertex = startVertex
        
        while vertex.neighbors.first != nil {
            let nextVertex = vertex.neighbors[0].destination
            shortestPath.append(nextVertex)
            vertex = nextVertex
        }
        
        
        return shortestPath
    }
}
