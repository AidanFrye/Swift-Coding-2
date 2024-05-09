//
//  Athlete.swift
//  FavoriteAthlete
//
//  Created by Aidan on 1/18/24.
//

import Foundation

struct Athlete: CustomStringConvertible
{
    var description: String
    {
        return "\(name) is \(age) years old and plays for the \(team) in the \(league)"
    }
    var name: String
    var age: Int
    var league: String
    var team: String
}
