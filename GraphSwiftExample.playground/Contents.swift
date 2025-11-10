import UIKit

let graph = AdjacencyMatrix<Int>()

let One = graph.CreateVertex(data: 1)
let Two = graph.CreateVertex(data: 2)
let Three = graph.CreateVertex(data: 3)
let Four = graph.CreateVertex(data: 4)
let Five = graph.CreateVertex(data: 5)
let Six = graph.CreateVertex(data: 6)
let Seven = graph.CreateVertex(data: 7)
let Eight = graph.CreateVertex(data: 8)
let Nine = graph.CreateVertex(data: 9)
let Ten = graph.CreateVertex(data: 10)

//One Outgoing
graph.AddDirectedEdge(from: One, to: Nine, weight: 1)
graph.AddDirectedEdge(from: One, to: Four, weight: 1)
graph.AddDirectedEdge(from: One, to: Five, weight: 1)

//Two Outgoing
graph.AddDirectedEdge(from: Two, to: Six, weight: 1)
graph.AddDirectedEdge(from: Two, to: Four, weight: 1)

//Three Outgoing
graph.AddDirectedEdge(from: Three, to: Ten, weight: 1)
graph.AddDirectedEdge(from: Three, to: Five, weight: 1)
graph.AddDirectedEdge(from: Three, to: Eight, weight: 1)

//Four Outgoing
graph.AddDirectedEdge(from: Four, to: Five, weight: 1)
graph.AddDirectedEdge(from: Four, to: Ten, weight: 1)

//Five Outgoing
graph.AddDirectedEdge(from: Five, to: Eight, weight: 1)

//Six Outgoing
graph.AddDirectedEdge(from: Six, to: Nine, weight: 1)
graph.AddDirectedEdge(from: Six, to: Eight, weight: 1)

//Seven Outgoing
graph.AddDirectedEdge(from: Seven, to: Eight, weight: 1)

//No Outgoing for Eight/Nine/Ten

print(graph)
