//
//  addView.swift
//  toyProject-TodoList
//
//  Created by 김명현 on 11/10/23.


import SwiftUI

struct AddView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
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
                    
                    //                    let newTodo = Todo(id: getNextID(), title: titleTextField, description: scheduleTextEditor, completed: false)
                    //                    todoData.append(newTodo) // id는 함수를 만들어 넣어주고 title에 TextField에 입력한 값, description애 TextEditor에 입력한값 completed는 false
                    //                    dismiss() // 새 스케줄을 만들어주고 ContentView로 이동
                    saveTodoToCoreData()
                }
                .font(.title2)
                .kerning(1)
                .disabled(titleTextField.isEmpty || scheduleTextEditor.isEmpty ? true : false)
            }
        }
        .navigationTitle("Add Schedule")
    }
    
    
    private func saveTodoToCoreData() {
        withAnimation {
            let newTodo = TodoItem(context: viewContext) // TodoEntity를 생성합니다.
            newTodo.todoTitle = titleTextField // title을 할당합니다.
            newTodo.todoDescription = scheduleTextEditor // description을 할당합니다.
            newTodo.todoCompleted = false // completed 상태를 할당합니다.
            
            do {
                try viewContext.save() // 변경된 내용을 저장합니다.
                dismiss() // 저장 후에는 View를 닫습니다.
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}






//#Preview {
//    AddView()
//}
