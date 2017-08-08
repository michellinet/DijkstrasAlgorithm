//
//  Official.swift
//  Dijkstra
//
//  Created by Michelline Tran on 8/7/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import Foundation

class AlgorithmOfTheDijkstraVariety {
    
    func processDijkstra(source: Node, destination: Node) -> Path? {
        
        var unvisitedSet = [Path()]
        var finalPaths = [Path()]
        
        //use source edges to create the unvisitedSet
        for e in source.neighbors {
            let newPath: Path = Path()
            newPath.destination = e.neighbor
            newPath.previous = nil
            newPath.total = e.weight

            unvisitedSet.append(newPath)
        }
        
        //construct the best path
        var bestPath = Path()
        
        while(unvisitedSet.count != 0) {
            
            var x = 0
            var pathIndex: Int = 0

            for (index, path) in unvisitedSet.enumerated() {
                var itemPath: Path = unvisitedSet[x]
                if (bestPath.total == nil) || (path.total < bestPath.total) {
                    bestPath = itemPath
                    pathIndex = x
                    
                    //preserve the bestPath
                    finalPaths.append(path)
                    //remove the bestPath from the unvisitedSet
                    unvisitedSet.remove(at: index)
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
            unvisitedSet.remove(at: pathIndex)

        }
        
        //establish the shortest path
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
