//
//  DetailView.swift
//  toyProject-TodoList
//
//  Created by 김명현 on 11/8/23.
//

import SwiftUI

struct DetailView: View {
    @State var todo: Todo
    @Binding var todoData: [Todo]
    
    var body: some View {
        VStack {
            Text("Title")
                .font(.title2)
                .offset(y: -80)
            TextField("Enter Title", text: $todo.title)
                .padding()
                .frame(height: 50)
                .border(Color.black, width: 1)
                .font(.headline)
                .offset(y: -80) // x , y 축 레이아웃 조절
            Text("Schedule")
                .font(.title2)
                .offset(y: -80)
                .padding(.top, 20)
            TextEditor(text: $todo.description)
                .frame(width: 360, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 12)) // 테두리 둥글게 안댐
                .border(Color.black, width: 1)
                .padding()
                .font(.headline)
                .offset(y: -80)
                .padding(.horizontal)
        }
        .onDisappear {
            if let index = todoData.firstIndex(where: { $0.id == todo.id }) {
                todoData[index] = todo
            }
            
        }
    }
}


//#Preview {
//    DetailView(todo: Todo(id: 1, title: "t", description: "d", completed: true))
//}


