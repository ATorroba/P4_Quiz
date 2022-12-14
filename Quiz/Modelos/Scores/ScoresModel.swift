//
//  ScoresModel.swift
//  Quiz
//
//  Created by Álvaro Torroba de Linos on 23/11/22.
//

import Foundation

class ScoresModel : ObservableObject {
    
    @Published private(set) var acertadas : Set<Int> = []
    
    func add(answer : String, quizItem : QuizItem){
        if answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == quizItem.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
            acertadas.insert(quizItem.id)
        }
    }
    
}
