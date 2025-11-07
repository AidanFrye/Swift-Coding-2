//
//  Vertex.swift
//  
//
//  Created by lab on 10/31/25.
//

public struct Vertex<T> //T is a generic type
{
    public let index: Int
    public let data: T
}

extension Vertex: Hashable where T: Hashable {}
extension Vertex: Equatable where T: Equatable {}
extension Vertex: CustomStringConvertible {
    public var description: String
    {
        "\(index): \(data)"
    }
}
