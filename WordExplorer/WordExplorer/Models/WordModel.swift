//
//  WordModel.swift
//  WordExplorer
//
//  Created by Damla Sahin on 20.03.2024.
//

import Foundation
struct WordDefinition: Codable {
    let word: String
    let phonetic: String?
    var meanings: [Meaning]
}

struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
    let synonyms: [String]?
    let antonmys: [String]?
}

struct Definition: Codable {
    let definition: String
    let example: String?
}


