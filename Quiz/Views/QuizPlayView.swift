//
//  QuizDetail.swift
//  Quiz
//
//  Created by Álvaro Torroba de Linos on 14/11/22.
//

import SwiftUI

struct QuizPlayView: View {
    
    var quizItem : QuizItem
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State private var answer: String = ""
    @State var showAlert: Bool = false
    @State var respuesta: String = ""
    @EnvironmentObject var scoresModels : ScoresModel
    
    var body: some View {
        VStack{
            cabecera
            if verticalSizeClass == .compact {
                HStack{
                    HStack{
                        VStack{
                            respuestaView
                            Spacer()
                            footer
                        }
                        attachment
                    } 
                }
                .padding(.all)
            } else {
                VStack{
                    respuestaView
                    attachment
                    footer
                }
                .padding(.all)
            }
        }
        .navigationTitle("Play")
    }
    
    private var cabecera : some View {
        HStack{
            Spacer()
            
            Text(quizItem.question)
                .fontWeight(.heavy)
                .font(.largeTitle)
            
            Image(systemName: quizItem.favourite ? "star.fill": "star")
                .foregroundColor(Color.yellow)
                .shadow(radius: 15)
                .font(.title)
            Spacer()
            
        }

    }
    
    private var respuestaView : some View {
        VStack{
            TextField("Respuesta", text: $answer)
                .onSubmit {
                    if answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == quizItem.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
                        respuesta = "Bien"
                        scoresModels.add(answer: answer, quizItem: quizItem)
                    } else {
                        respuesta = "Mal"
                    }
                    showAlert = true
                }
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            Label("Comprobar", systemImage: "questionmark.circle.fill")
                .foregroundColor(Color.blue)
                .onTapGesture {
                    if answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == quizItem.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
                        respuesta = "Bien"
                        scoresModels.add(answer: answer, quizItem: quizItem)
                        
                    }else{
                        respuesta = "Mal"
                    }
                    showAlert = true
                }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Respuesta"),
                message: Text(respuesta),
                dismissButton: .default(Text("Ok"))
            )
        }
    }
    
    private var attachment : some View {
        GeometryReader { geom in
            MyAsyncImage(url: quizItem.attachment?.url)
                .frame(width: geom.size.width, height: geom.size.height)
                .cornerRadius(16)
                .shadow(radius: 15)
        }
    }
    
    private var footer : some View {
        HStack{
            Text("\(scoresModels.acertadas.count)")
                .fontWeight(.heavy)
                .font(.title2)
            Spacer()
            Text(quizItem.author?.username  ?? "Anónimo")
            
            MyAsyncImage(url: quizItem.author?.photo?.url)
                .frame(width: 35, height: 35)
                .clipShape(Circle())
                .shadow(radius: 15)
        }
    }
}

struct QuizPlayView_Previews: PreviewProvider {
    
    static var qm : QuizzesModel = {
        var qm = QuizzesModel()
        qm.load()
        return qm
    }()
    
    static var previews: some View {
        VStack{
            QuizPlayView(quizItem: qm.quizzes[0])
        }
    }
}
