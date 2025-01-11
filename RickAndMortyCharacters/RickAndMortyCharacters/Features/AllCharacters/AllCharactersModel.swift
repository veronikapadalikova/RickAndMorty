//
//  AllCharactersModel.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 11.01.2025.
//

struct Character: Decodable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: CharacterGender
    let origin: CharacterOrigin
    let location: CharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct CharacterOrigin: Decodable {
    let name: String
    let url: String
}

struct CharacterLocation: Decodable {
    let name: String
    let url: String
}

enum CharacterStatus: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum CharacterGender: String, Decodable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}

// MARK: Sample character
extension Character {
    static var sample: Character {
        Character(id: 1,
                  name: "Rick Sanchez",
                  status: .alive,
                  species: "Human",
                  type: "",
                  gender: .male,
                  origin: CharacterOrigin(name: "Earth", url: "https://rickandmortyapi.com/api/location/1"),
                  location: CharacterLocation(name: "Earth", url: "https://rickandmortyapi.com/api/location/20"),
                  image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                  episode: [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2"
                  ],
                  url: "https://rickandmortyapi.com/api/character/1",
                  created: "2017-11-04T18:48:46.250Z")
    }
}
