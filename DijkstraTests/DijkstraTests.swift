//
//  DijkstraTests.swift
//  DijkstraTests
//
//  Created by Michelline Tran on 7/14/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import XCTest
@testable import Dijkstra

class DijkstraTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSimpleGraph() {
        let endingVertex = Vertex(key: "B", neighbors: [])
        let startingVertex = Vertex(key: "A", neighbors: [Edge(destination: endingVertex, weight: 5)])
        
        let simpleGraph = Graph(vertices: [startingVertex, endingVertex])
        let shortestPath = simpleGraph.processDijkstra(source: startingVertex.key, to: endingVertex.key)
        let expectedPath = [startingVertex, endingVertex]
        
        XCTAssertEqual(expectedPath, shortestPath)
    }
    
    func testNotSoSimpleGraph() {
        let endingVertex = Vertex(key: "E", neighbors: [])
        let middleVertex = Vertex(key: "D", neighbors: [Edge(destination: endingVertex, weight: 8)])
        let startingVertex = Vertex(key: "A", neighbors: [Edge(destination: middleVertex, weight: 4)])
        let simpleGraph = Graph(vertices: [startingVertex, endingVertex, middleVertex])
        
        let shortestPath = simpleGraph.processDijkstra(source: startingVertex.key, to: endingVertex.key)
        let expectedPath = [startingVertex, middleVertex, endingVertex]
        
        XCTAssertEqual(expectedPath, shortestPath)
    }
    
    func testExtraNodeInGraph() {
        let extraVertex = Vertex(key: "M", neighbors: [])
        let endingVertex = Vertex(key: "E", neighbors: [Edge(destination: extraVertex, weight: 3)])
        let middleVertex = Vertex(key: "D", neighbors: [Edge(destination: endingVertex, weight: 8)])
        let startingVertex = Vertex(key: "A", neighbors: [Edge(destination: middleVertex, weight: 4)])
        let simpleGraph = Graph(vertices: [startingVertex, endingVertex, middleVertex])
        
        let shortestPath = simpleGraph.processDijkstra(source: startingVertex.key, to: endingVertex.key)
        let expectedPath = [startingVertex, middleVertex, endingVertex]
        
        XCTAssertEqual(expectedPath, shortestPath)
    }

    func testMultipleOptionsGraph() {
        let vertexM = Vertex(key: "M", neighbors: [])
        let vertexE = Vertex(key: "E", neighbors: [Edge(destination: vertexM, weight: 3)])
        let vertexD = Vertex(key: "D", neighbors: [Edge(destination: vertexE, weight: 8)])
        var vertexA = Vertex(key: "A", neighbors: [Edge(destination: vertexD, weight: 4)])
        let vertexB = Vertex(key: "B", neighbors: [Edge(destination: vertexA, weight: 3), Edge(destination: vertexE, weight: 1)])
        vertexA.neighbors.append(Edge(destination: vertexB, weight: 3))

        let simpleGraph = Graph(vertices: [vertexA, vertexD, vertexE, vertexM, vertexB])

        let shortestPath = simpleGraph.processDijkstra(source: vertexA.key, to: vertexE.key)
        let expectedPath = [vertexA, vertexB, vertexE]

        XCTAssertEqual(expectedPath, shortestPath)
    }
}
