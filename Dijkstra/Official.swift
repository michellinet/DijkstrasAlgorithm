//
//  Official.swift
//  Dijkstra
//
//  Created by Michelline Tran on 8/7/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import Foundation

class OGraph {
    private var canvas = [Node]()
    
    func addNode(key: String) -> Node {
        //set the key
        let childNode = Node()
        childNode.key = key
        
        //add the node to the graph canvas
        canvas.append(childNode)
        return childNode
    }
    
    func addEdge(source: Node, neighbor: Node, weight: Int) {
        let newOEdge = OEdge()
        newOEdge.neighbor = neighbor
        newOEdge.weight = weight
        source.neighbors.append(newOEdge)
        
        //check for undirected graph
        // if (isDirected == false) {
        
        //create a new reversed edge
        let reverseOEdge = OEdge()
        
        //establish the reversed properties
        reverseOEdge.neighbor = source
        reverseOEdge.weight = weight
        neighbor.neighbors.append(reverseOEdge)
        //   }
    }
    
    func processDijkstra(source: Node, destination: Node) -> Path? {
        
        var unvisitedSet = [Path()]
        var finalPaths = [Path()]
        
//Use our source's edges to create the unvisitedSet.
            //This set is our current options of paths to take to the next node.
        for edge in source.neighbors {
            let newPath: Path = Path()
            newPath.destination = edge.neighbor
            newPath.previous = nil
            newPath.total = edge.weight

            unvisitedSet.append(newPath)
        }
        
//Find the bestPath.
            //This path will have the smallest weight.
        var bestPath = Path()
        
        
            //while the unvisitedSet still has items
        while(unvisitedSet.count != 0) {
            //support path changes using the greedy approach
            bestPath = Path()
            
            for path in unvisitedSet {
                if (bestPath.total == nil) || (path.total < bestPath.total) {
                    bestPath = path
                }
            }
            
            //reset unvisited set, enumerate the bestPath edges
            for edge in bestPath.destination.neighbors {
                let newPath: Path = Path()
                newPath.destination = edge.neighbor
                newPath.previous = bestPath
                newPath.total = bestPath.total + edge.weight
            
                unvisitedSet.append(newPath)
            }
            
            //preserve the bestPath
            finalPaths.append(bestPath)
            
            //remove the bestPath from the unvisitedSet
            if let bestPathIndex = unvisitedSet.index(of: bestPath) {
                  unvisitedSet.remove(at: bestPathIndex)
            }
        }
        
        
        
//Establish the shortest path.
        
        var shortestPath = Path()
        
        for path in finalPaths {
            if (path.destination.key == destination.key) {
                if (shortestPath.total == nil) || (path.total < shortestPath.total) {
                    shortestPath = path
                }
            }
        }
        
        return shortestPath
    }
}
