//
//  addView.swift
//  toyProject-TodoList
//
//  Created by 김명현 on 11/10/23.
//

import SwiftUI

struct AddView: View {
    @Binding var todoData: [Todo]
    @State private var titleTextField = ""
    @State private var scheduleTextEditor = ""
    @Environment(\.dismiss) var dismiss // Environment 프로퍼티 래퍼 정확히 무슨 기능인지 모르겠음
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Title ")
                    .font(.headline)
                    
                    .offset(y: 10) // 레이아웃 조절
                TextField("", text: $titleTextField) 
                    .frame(height: 35)
                    .overlay(RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 1))
                    .padding()
                Text("Schedule")
                    .font(.headline)
                TextEditor(text: $scheduleTextEditor)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1))
                    .padding()
                Spacer(minLength: 30)
                
                Button("ADD") {
                    let newTodo = Todo(id: getNextID(), title: titleTextField, description: scheduleTextEditor, completed: false)
                    todoData.append(newTodo) // id는 함수를 만들어 넣어주고 title에 TextField에 입력한 값, description애 TextEditor에 입력한값 completed는 false
                    dismiss() // 새 스케줄을 만들어주고 ContentView로 이동
                }
                .font(.title2)
                .kerning(1)
                .disabled(titleTextField.isEmpty || scheduleTextEditor.isEmpty ? true : false)
            }
        }
        .navigationTitle("Add Schedule")
        
            
    }
    
    private func getNextID() -> Int { // 새로 만들어질 List 요소 id 값 생성해주는 함수 ( 마지막 요소 id 값에 + 1 을 해준다)
        if let lastTodo = todoData.last {
            return lastTodo.id + 1
        } else {
            return 1
        }
    }

}

//#Preview {
//    AddView()
//}
