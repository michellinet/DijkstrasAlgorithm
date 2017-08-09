//
//  Graph.swift
//  Dijkstra
//
//  Created by Michelline Tran on 7/14/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import Foundation
//
//struct Graph {
//    var vertices: Array<Vertex>
//    
//    func processDijkstra(source: String,to endingDestination: String) -> [Vertex] {
//        var shortestPath = [Vertex]()
//        
//        let startingVertex = vertices.first { (vertex) -> Bool in
//            vertex.key == source
//        }
//        
//        guard let startVertex = startingVertex else { return shortestPath }
//        shortestPath.append(startVertex)
//        
//        var vertex = startVertex
//        
//        while vertex.neighbors.first != nil {
//            let leastWeightNeighbor = vertex.neighbors.min(by: { (a, b) -> Bool in a.weight < b.weight } )
//
//            guard let nextVertex = leastWeightNeighbor?.destination else { return shortestPath }
//            shortestPath.append(nextVertex)
//
//            if nextVertex.key == endingDestination {
//                break
//            } else {
//                vertex = nextVertex
//            }
//        }
//
//        return shortestPath
//    }
//}
