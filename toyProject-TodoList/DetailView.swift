//
//  DetailView.swift
//  toyProject-TodoList
//
//  Created by 김명현 on 11/8/23.
//

import SwiftUI

struct DetailView: View {
   @State  var todo: Todo
    var body: some View {
        VStack {
            Text("Todo")
                .font(.title3)
                .padding()
            TextField("Enter your schedule", text: $todo.description)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .textFieldStyle(.roundedBorder)
            
            
            
        }
    }
}

#Preview {
    DetailView(todo: Todo(id: 1, title: "t", description: "d", completed: true))
}
