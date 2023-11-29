//
//  DetailView.swift
//  toyProject-TodoList
//
//  Created by 김명현 on 11/8/23.
//

import SwiftUI

struct DetailView: View {
    @State var todo: Todo

    
    var body: some View {
        VStack {
            Text("Schedule")
                .font(.headline)
                .padding()
                .offset(y: -80) // x , y 축 레이아웃 조절
            Text(todo.description)
                .padding()
                .font(.headline)
                .textFieldStyle(.roundedBorder)
                .offset(y: -80)
        }

    }
}
    

#Preview {
    DetailView(todo: Todo(id: 1, title: "t", description: "d", completed: true))
}
