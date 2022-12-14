//
//  ContentView.swift
//  Quiz
//
//  Created by Torroba on 11/11/22.
//

import SwiftUI

struct QuizzesView: View {
    
    @EnvironmentObject var quizzesModel : QuizzesModel
    
    var body: some View {
        NavigationStack{
            Text("Escoge un Quiz")
                .font(.title)
            List {
                ForEach(quizzesModel.quizzes) { quizItem in
                    
                    NavigationLink{
                        QuizPlayView(quizItem: quizItem)
                    }label: {
                        QuizRow(quizItem: quizItem)
                    }
                }
                
//                Text("\(quizItem.count) Quizzes")
            }
            .listStyle(.plain)
            .navigationTitle("Quizzes")
            .onAppear {
                quizzesModel.load()
            }
            

        }
    }
}


struct QuizView_Previews: PreviewProvider {
    
    static var qm : QuizzesModel = {
        var qm = QuizzesModel()
        qm.load()
        return qm
    }()
    
    static var previews: some View {
            QuizzesView()
            .environmentObject(qm)
    }
}
