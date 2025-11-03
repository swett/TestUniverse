//
//  QuestionModel.swift
//  TestUniverse
//
//  Created by Mykyta Kurochka on 02.11.2025.
//

import Foundation
struct QuestionResponse: Codable {
    let items: [QuestionModel]
}

struct QuestionModel: Codable {
    let id: Int
    let question: String
    let answers: [String]
}
