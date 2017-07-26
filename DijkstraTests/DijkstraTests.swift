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
}
