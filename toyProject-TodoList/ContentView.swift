//
//  ContentView.swift
//  toyProject-TodoList
//
//  Created by 김명현 on 11/8/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var showCompleted = false
    @State private var todoData: [Todo] = Parsing().load("sample.json") // Edit모드에서 삭제 적용이 안돼서 전역변수에서 여기로 옮김
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(todoData, id: \.self) { todo in
                    HStack {
                        Button(action: { // 버튼이 안눌러짐 : row에 같은 탭 제스처를 수신하는 View 두개가 있는 경우에 이를 독립적으로 인식하지 않고 동시 작동된다. 이를 해결하기 위해서 버튼스타일을 별도로 지정해서 독립시킨다.
                            toggleCompleted(todo)
                        }
                               , label: {
                            Image(systemName: todo.completed ? "checkmark.circle.fill" : "checkmark.circle")
                        })
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: DetailView(todo: todo, todoData: $todoData)) {
                            Text(todo.title)
                                .font(.headline)
                        }
                    }
                    
                }
                .onDelete(perform: delte) // 삭제 기능 삽입 (함수를 호출했는데 왜 delte()를 안해줘도 되는것인가?)
                .onMove{ todoData.move(fromOffsets: $0, toOffset: $1) }
                
            }
            .navigationBarItems(leading: EditButton(), trailing: NavigationLink(destination: AddView(todoData: $todoData) , label: { Text("Add") })) // barItem 설정
            .listStyle(.inset)
            .navigationTitle("Todo-List")
        }
        .padding()
    }
    
    
    func delte(at offsets: IndexSet) { // 삭제 함수
        if let first = offsets.first {
            todoData.remove(at: first)
        }
    }
    
    func toggleCompleted(_ todo: Todo) {
        if let index = todoData.firstIndex(where: { $0.id == todo.id }) {
            todoData[index].completed.toggle()
        }
    }
    
}

#Preview {
    ContentView()
}
