//
//  Edge.swift
//  
//
//  Created by lab on 10/31/25.
//

public struct Edge<T> {
    public let source: Vertex<T>
    public let destination: Vertex<T>
    public let weight: Double?
}
