//
//  DetailView.swift
//  toyProject-TodoList
//
//  Created by 김명현 on 11/8/23.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var todoItem: TodoItem
    
    var body: some View {
        VStack {
            Text("Title")
                .font(.title2)
                .offset(y: -80)
            
            TextField("Enter Title", text: Binding<String>(
                get: {
                    todoItem.todoTitle ?? ""
                },
                set: { newValue in
                    todoItem.todoTitle = newValue
                    saveChanges()
                }
            ))
            .frame(height: 50)
            .overlay(RoundedRectangle(cornerRadius: 6)
            .stroke(Color.black, lineWidth: 1))
            .font(.headline)
            .offset(y: -80) // x , y 축 레이아웃 조절
            
            
            Text("Schedule")
                .font(.title2)
                .offset(y: -80)
                .padding(.top, 20)
            
            TextEditor(text: Binding<String>(
                get: {
                    todoItem.todoDescription ?? ""
                },
                set: { newValue in
                    todoItem.todoDescription = newValue
                    saveChanges()
                }
            ))
            .frame(width: 340, height: 100)
            .overlay(RoundedRectangle(cornerRadius: 6)
            .stroke(Color.black, lineWidth: 1))
            .padding()
            .font(.headline)
            .offset(y: -80)
            .padding(.horizontal)
        }
        
    }
    
    private func saveChanges() {
        do {
            try viewContext.save()
        } catch {
            print("Could not save changes: \(error)")
        }
    }
}


//#Preview {
//    DetailView(todo: Todo(id: 1, title: "t", description: "d", completed: true))
//}


