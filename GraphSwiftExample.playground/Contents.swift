import UIKit

let graph = AdjacencyMatrix<String>()

let singapore = graph.CreateVertex(data: "Singapore")
let tokyo = graph.CreateVertex(data: "Tokyo")
let hongKong = graph.CreateVertex(data: "Hong Kong")
let detroit = graph.CreateVertex(data: "Detroit")
let sanFrancisco = graph.CreateVertex(data: "San Francisco")
let washingtonDC = graph.CreateVertex(data: "Eashington DC")
let austin = graph.CreateVertex(data: "Austin")
let seattle = graph.CreateVertex(data: "Seattle")

graph.Add(.undirected, from: singapore, to: hongKong, weight: 300)
graph.Add(.undirected, from: singapore, to: tokyo, weight: 500)
graph.Add(.undirected, from: hongKong, to: tokyo, weight: 250)
graph.Add(.undirected, from: tokyo, to: detroit, weight: 450)
graph.Add(.undirected, from: tokyo, to: washingtonDC, weight: 300)
graph.Add(.undirected, from: hongKong, to: sanFrancisco, weight: 600)
graph.Add(.undirected, from: detroit, to: austin, weight: 50)
graph.Add(.undirected, from: austin, to: washingtonDC, weight: 292)
graph.Add(.undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
graph.Add(.undirected, from: washingtonDC, to: seattle, weight: 277)
graph.Add(.undirected, from: sanFrancisco, to: seattle, weight: 218)
graph.Add(.undirected, from: austin, to: sanFrancisco, weight: 297)

print(graph)

graph.Weight(from: singapore, to: tokyo)

print("San Francisco Outgoing Flights: ")
print("--------------------------------")
for edge in graph.Edges(from: sanFrancisco)
{
    print("from: \(edge.source) to: \(edge.destination)")
}
