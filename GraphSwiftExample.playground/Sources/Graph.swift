//
//  Graph.swift
//  
//
//  Created by lab on 10/31/25.
//

public enum EdgeType //two types of edges, directed and undirected
{
    case directed
    case undirected
}

public  protocol Graph
{
    associatedtype Element //generic type to allow for any data type
                           // e.g. string / int / bool
    
    func CreateVertex(data: Element) -> Vertex<Element> //creates vertex and adds it to graph
    func AddDirectedEdge(from source: Vertex<Element>, to destination<Element>, weight: Double?) //add directed edge between the source vertex and the destination vertex, with an optional weight
    func AddUndirectedEdge(from source: Vertex<Element>, to destination<Element, weight: Double?) //add undirected edge between source vertex and destination vertex with optional weight
    func Add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertext<Element>, weight: Double?) //add edges to graph after determining if directed or undirected
    func Edges(from source: Vertex<Element>, to destination: Vertex<Element>) //gives back list of outgoing edges from a vertex
    func Weight(from source: Vertex<Element>, to destination: Vertex>Element>) -> Double? //returns optional value of weight between 2 vertices
}

extension Graph
{
    //creates undirected edge as a sum of 2 different opposing directed edges
    public func AddUndirectedEdge(between source: Vertex<Element>, and destination: Vertex<Element>, weight: Double?)
    {
        AddDirectedEdge(from: source, to: destination, weight: weight)
        AddDirectedEdge(from: destination, to: source, weight: weight)
    }
    
    public func Add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    {
        switch edge
        {
            case .directed:
                AddDirectedEdge(from: source, to: destination, weight: weight)
            case .undirected:
                AddUndirectedEdge(from: source, to: destination, weight: weight)
        }
        
    }
}

