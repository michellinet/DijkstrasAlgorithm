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

    func testMoreMultipleOptionsGraph() {
        let vertexM = Vertex(key: "M", neighbors: [])
        let vertexE = Vertex(key: "E", neighbors: [Edge(destination: vertexM, weight: 3)])
        var vertexD = Vertex(key: "D", neighbors: [Edge(destination: vertexE, weight: 8)])
        var vertexA = Vertex(key: "A", neighbors: [Edge(destination: vertexD, weight: 4)])
        let vertexB = Vertex(key: "B", neighbors: [Edge(destination: vertexA, weight: 3), Edge(destination: vertexE, weight: 1)])
        vertexA.neighbors.append(Edge(destination: vertexB, weight: 3))
        vertexD.neighbors.append(Edge(destination: vertexB, weight: 5))

        let simpleGraph = Graph(vertices: [vertexA, vertexD, vertexE, vertexM, vertexB])

        let shortestPath = simpleGraph.processDijkstra(source: vertexA.key, to: vertexE.key)
        let expectedPath = [vertexA, vertexB, vertexE]

        XCTAssertEqual(expectedPath, shortestPath)
    }

    func testVerticesWeDontNeed() {
        let vertexM = Vertex(key: "M", neighbors: [])
        let vertexE = Vertex(key: "E", neighbors: [Edge(destination: vertexM, weight: 3)])
        var vertexD = Vertex(key: "D", neighbors: [Edge(destination: vertexE, weight: 8)])
        var vertexA = Vertex(key: "A", neighbors: [Edge(destination: vertexD, weight: 4)])
        let vertexB = Vertex(key: "B", neighbors: [Edge(destination: vertexA, weight: 3), Edge(destination: vertexE, weight: 1)])
        vertexA.neighbors.append(Edge(destination: vertexB, weight: 3))
        vertexD.neighbors.append(Edge(destination: vertexB, weight: 5))

        let simpleGraph = Graph(vertices: [vertexA, vertexD, vertexE, vertexM, vertexB])

        let shortestPath = simpleGraph.processDijkstra(source: vertexA.key, to: vertexB.key)
        let expectedPath = [vertexA, vertexB]

        XCTAssertEqual(expectedPath, shortestPath)
    }

    func testLotsOfVerticesInPath() {
        let vertexM = Vertex(key: "M", neighbors: [])
        let vertexE = Vertex(key: "E", neighbors: [Edge(destination: vertexM, weight: 3)])
        var vertexD = Vertex(key: "D", neighbors: [Edge(destination: vertexE, weight: 8)])
        var vertexA = Vertex(key: "A", neighbors: [Edge(destination: vertexD, weight: 4)])
        let vertexB = Vertex(key: "B", neighbors: [Edge(destination: vertexA, weight: 3), Edge(destination: vertexE, weight: 1)])
        vertexA.neighbors.append(Edge(destination: vertexB, weight: 3))
        vertexD.neighbors.append(Edge(destination: vertexB, weight: 5))

        let simpleGraph = Graph(vertices: [vertexA, vertexD, vertexE, vertexM, vertexB])

        let shortestPath = simpleGraph.processDijkstra(source: vertexA.key, to: vertexM.key)
        let expectedPath = [vertexA, vertexB, vertexE, vertexM]

        XCTAssertEqual(expectedPath, shortestPath)
    }

    // Tests for Official Algorithm
    
    func testOfficial() {
        let graph = OGraph()
        let nodeA = graph.addNode(key: "A")
        let nodeB = graph.addNode(key: "B")
        graph.addEdge(source: nodeA, neighbor: nodeB, weight: 1)

        var shortestPath = Path()
        if let actualPath = graph.processDijkstra(source: nodeA, destination: nodeB) {
            shortestPath = actualPath
        }
        let shortestPathString = shortestPath.printNodesInPath(source: nodeA)
        
        let expectedPath = Path()
        expectedPath.total = 1
        expectedPath.destination = nodeB
        expectedPath.previous = nil
        let expectedPathString = "AB"
        
        XCTAssertEqual(expectedPath.total, shortestPath.total)
        XCTAssertEqual(expectedPath.destination, shortestPath.destination)
        XCTAssertEqual(expectedPathString, shortestPathString)

    }

    func testOfficial2() {
        let graph = OGraph()
        let nodeA = graph.addNode(key: "A")
        let nodeD = graph.addNode(key: "D")
        let nodeE = graph.addNode(key: "E")
        graph.addEdge(source: nodeA, neighbor: nodeD, weight: 4)
        graph.addEdge(source: nodeD, neighbor: nodeE, weight: 8)

        var shortestPath = Path()
        if let actualPath = graph.processDijkstra(source: nodeA, destination: nodeE) {
            shortestPath = actualPath
        }
        let shortestPathString = shortestPath.printNodesInPath(source: nodeA)

        let expectedPath = Path()
        expectedPath.total = 12
        expectedPath.destination = nodeE
        expectedPath.previous = nil
        let expectedPathString = "ADE"

        XCTAssertEqual(expectedPath.total, shortestPath.total)
        XCTAssertEqual(expectedPath.destination, shortestPath.destination)
        XCTAssertEqual(expectedPathString, shortestPathString)

    }

    func testOfficial3() {
        let graph = OGraph()
        let nodeA = graph.addNode(key: "A")
        let nodeB = graph.addNode(key: "B")
        let nodeD = graph.addNode(key: "D")
        let nodeE = graph.addNode(key: "E")
        let nodeM = graph.addNode(key: "M")
        graph.addEdge(source: nodeE, neighbor: nodeM, weight: 3)
        graph.addEdge(source: nodeD, neighbor: nodeE, weight: 8)
        graph.addEdge(source: nodeA, neighbor: nodeD, weight: 4)
        graph.addEdge(source: nodeA, neighbor: nodeB, weight: 3)
        graph.addEdge(source: nodeB, neighbor: nodeE, weight: 1)

        var shortestPath = Path()
        if let actualPath = graph.processDijkstra(source: nodeA, destination: nodeE) {
            shortestPath = actualPath
        }
        let shortestPathString = shortestPath.printNodesInPath(source: nodeA)

        let expectedPath = Path()
        expectedPath.total = 4
        expectedPath.destination = nodeE
        let expectedPathString = "ABE"

        XCTAssertEqual(expectedPath.total, shortestPath.total)
        XCTAssertEqual(expectedPath.destination, shortestPath.destination)
        XCTAssertEqual(expectedPathString, shortestPathString)
    }

    func testOfficial4() {
        let graph = OGraph()
        let nodeA = graph.addNode(key: "A")
        let nodeB = graph.addNode(key: "B")
        let nodeD = graph.addNode(key: "D")
        let nodeE = graph.addNode(key: "E")
        let nodeM = graph.addNode(key: "M")
        graph.addEdge(source: nodeE, neighbor: nodeM, weight: 3)
        graph.addEdge(source: nodeD, neighbor: nodeE, weight: 8)
        graph.addEdge(source: nodeA, neighbor: nodeD, weight: 4)
        graph.addEdge(source: nodeA, neighbor: nodeB, weight: 3)
        graph.addEdge(source: nodeB, neighbor: nodeE, weight: 1)
        graph.addEdge(source: nodeD, neighbor: nodeB, weight: 5)

        var shortestPath = Path()
        if let actualPath = graph.processDijkstra(source: nodeA, destination: nodeE) {
            shortestPath = actualPath
        }
        let shortestPathString = shortestPath.printNodesInPath(source: nodeA)

        let expectedPath = Path()
        expectedPath.total = 4
        expectedPath.destination = nodeE
        let expectedPathString = "ABE"

        XCTAssertEqual(expectedPath.total, shortestPath.total)
        XCTAssertEqual(expectedPath.destination, shortestPath.destination)
        XCTAssertEqual(expectedPathString, shortestPathString)
    }


    func testOfficial5() {
        let graph = OGraph()
        let nodeB = graph.addNode(key: "B")
        let nodeS = graph.addNode(key: "S")
        let nodeD = graph.addNode(key: "D")
        let nodeC = graph.addNode(key: "C")

        graph.addEdge(source: nodeS, neighbor: nodeB, weight: 24)
        graph.addEdge(source: nodeS, neighbor: nodeD, weight: 20)
        graph.addEdge(source: nodeS, neighbor: nodeC, weight: 3)
        graph.addEdge(source: nodeC, neighbor: nodeD, weight: 12)

        var shortestPath = Path()
        if let actualPath = graph.processDijkstra(source: nodeS, destination: nodeB) {
            shortestPath = actualPath
        }
        let shortestPathString = shortestPath.printNodesInPath(source: nodeS)

        let expectedPath = Path()
        expectedPath.total = 24
        expectedPath.destination = nodeB
        let expectedPathString = "SB"

        XCTAssertEqual(expectedPath.total, shortestPath.total)
        XCTAssertEqual(expectedPath.destination, shortestPath.destination)
        XCTAssertEqual(expectedPathString, shortestPathString)
    }

    func testOfficial6() {
        let graph = OGraph()
        let nodeB = graph.addNode(key: "B")
        let nodeS = graph.addNode(key: "S")
        let nodeD = graph.addNode(key: "D")
        let nodeC = graph.addNode(key: "C")

        graph.addEdge(source: nodeS, neighbor: nodeB, weight: 24)
        graph.addEdge(source: nodeS, neighbor: nodeD, weight: 20)
        graph.addEdge(source: nodeS, neighbor: nodeC, weight: 3)
        graph.addEdge(source: nodeC, neighbor: nodeD, weight: 12)

        var shortestPath = Path()
        if let actualPath = graph.processDijkstra(source: nodeS, destination: nodeC) {
            shortestPath = actualPath
        }
        let shortestPathString = shortestPath.printNodesInPath(source: nodeS)

        let expectedPath = Path()
        expectedPath.total = 3
        expectedPath.destination = nodeC
        let expectedPathString = "SC"

        XCTAssertEqual(expectedPath.total, shortestPath.total)
        XCTAssertEqual(expectedPath.destination, shortestPath.destination)
        XCTAssertEqual(expectedPathString, shortestPathString)
    }


    func testOfficial7() {
        let graph = OGraph()
        let nodeB = graph.addNode(key: "B")
        let nodeS = graph.addNode(key: "S")
        let nodeD = graph.addNode(key: "D")
        let nodeC = graph.addNode(key: "C")

        graph.addEdge(source: nodeS, neighbor: nodeB, weight: 24)
        graph.addEdge(source: nodeS, neighbor: nodeD, weight: 20)
        graph.addEdge(source: nodeS, neighbor: nodeC, weight: 3)
        graph.addEdge(source: nodeC, neighbor: nodeD, weight: 12)

        var shortestPath = Path()
        if let actualPath = graph.processDijkstra(source: nodeS, destination: nodeD) {
            shortestPath = actualPath
        }
        let shortestPathString = shortestPath.printNodesInPath(source: nodeS)

        let expectedPath = Path()
        expectedPath.total = 15
        expectedPath.destination = nodeD
        let expectedPathString = "SCD"

        XCTAssertEqual(expectedPath.total, shortestPath.total)
        XCTAssertEqual(expectedPath.destination, shortestPath.destination)
        XCTAssertEqual(expectedPathString, shortestPathString)
    }


    func testOfficial8() {
        let graph = OGraph()
        let nodeB = graph.addNode(key: "B")
        let nodeS = graph.addNode(key: "S")
        let nodeD = graph.addNode(key: "D")
        let nodeC = graph.addNode(key: "C")

        graph.addEdge(source: nodeS, neighbor: nodeB, weight: 24)
        graph.addEdge(source: nodeD, neighbor: nodeS, weight: 20)
        graph.addEdge(source: nodeC, neighbor: nodeS, weight: 3)
        graph.addEdge(source: nodeD, neighbor: nodeC, weight: 12)

        var shortestPath = Path()
        if let actualPath = graph.processDijkstra(source: nodeD, destination: nodeS) {
            shortestPath = actualPath
        }
        let shortestPathString = shortestPath.printNodesInPath(source: nodeD)

        let expectedPath = Path()
        expectedPath.total = 15
        expectedPath.destination = nodeS
        let expectedPathString = "DCS"

        XCTAssertEqual(expectedPath.total, shortestPath.total)
        XCTAssertEqual(expectedPath.destination, shortestPath.destination)
        XCTAssertEqual(expectedPathString, shortestPathString)
    }


}
