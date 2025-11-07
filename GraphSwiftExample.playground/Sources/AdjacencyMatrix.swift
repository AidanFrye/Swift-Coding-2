//
//  AdjacencyMatrix.swift
//  
//
//  Created by lab on 10/31/25.
//

public class AdjacencyMatrix<T>: Graph
{
    private var vertices: [Vertex<T>] = []
    private var weights: [[Double?]] = []
    
    public init()
    {
        
        
    }
    
    public func CreateVertex(data: T) -> Vertex<T>
    {
        let vertex = Vertex(index: vertices.count, data: data)
        vertices.append(vertex)
        for i in 0..<weights.count
        {
            weights[i].append(nil)
        }
        let row = [Double?](repeating: nil, count: vertices.count)
        weights.append(row)
        return vertex
    }
    
    public func AddDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        weights[source.index][destination.index] = weight
    }
    
    public func Edges(from source: Vertex<T>) -> [Edge<T>] {
        var edges: [Edge<T>] = []
        for column in 0..<weights.count
        {
            if let weight = weights[source.index][column]
            {
                edges.append(Edge(source: source, destination: vertices[column], weight: weight))
            }
        }
        return edges
    }
    
    public func Weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        return weights[source.index][destination.index]
    }
}

extension AdjacencyMatrix: CustomStringConvertible
{
    public var description: String
    {
        let verticesDescription = vertices.map { "\($0)"}.joined(separator: "\n")
        var grid: [String] = []
        for i in 0..<weights.count
        {
            var row = ""
            for j in 0..<weights.count
            {
                if let value = weights[i][j]
                {
                    row += "\(value) \t"
                } else
                {
                    row += "0 \t\t"
                }
            }
            grid.append(row)
        }
        let edgeDescription = grid.joined(separator: "\n")
        return "\(verticesDescription) \n\n \(edgeDescription)"
    }
}
