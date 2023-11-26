//
//  ContentView.swift
//  toyProject-TodoList
//
//  Created by 김명현 on 11/8/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showCompleted = false
<<<<<<< Updated upstream
    @State private var todoData: [Todo] = Parsing.load("sample.json") // Edit모드에서 삭제 적용이 안돼서 전역변수에서 여기로 옮김
=======
    @State private var todoData: [Todo] = Parsing().load("sample.json") // Edit모드에서 삭제 적용이 안돼서 전역변수에서 여기로 옮김
>>>>>>> Stashed changes
    
    
    
    var body: some View {
        NavigationStack {
            List{
<<<<<<< Updated upstream
                ForEach(todoData, id: \.id) { data in
                    HStack {
                        Button(action: { // 버튼이 안눌러짐 : row에 같은 탭 제스처를 수신하는 View 두개가 있는 경우에 이를 독립적으로 인식하지 않고 동시 작동된다. 이를 해결하기 위해서 버튼스타일을 별도로 지정해서 독립시킨다.
                            toggleCompleted(at: data.id)
                        }
                               , label: {
                            Image(systemName: data.completed ? "checkmark.circle.fill" : "checkmark.circle")
=======
                ForEach(todoData, id: \.self) { todo in
                    HStack {
                        Button(action: { // 버튼이 안눌러짐 : row에 같은 탭 제스처를 수신하는 View 두개가 있는 경우에 이를 독립적으로 인식하지 않고 동시 작동된다. 이를 해결하기 위해서 버튼스타일을 별도로 지정해서 독립시킨다.
                            toggleCompleted(at: todo.id)
                        }
                               , label: {
                            Image(systemName: todoData[todo.id].completed ? "checkmark.circle.fill" : "checkmark.circle")
>>>>>>> Stashed changes
                        })
                        .buttonStyle(.plain)
                        
<<<<<<< Updated upstream
                        NavigationLink(destination: DetailView(todo: data)) {
                            Text(data.title)
=======
                       
                        NavigationLink(destination: DetailView(todo: todoData[todo.id])) {
                            Text(todoData[todo.id].title)
>>>>>>> Stashed changes
                                .font(.headline)
                        }
                    }
                }
                .onDelete(perform: delete) // 삭제 기능 삽입 (함수를 호출했는데 왜 delte()를 안해줘도 되는것인가?
                .onMove{ todoData.move(fromOffsets: $0, toOffset: $1) }
                
            }
            .navigationBarItems(leading: EditButton(), trailing: NavigationLink(destination: AddView(todoData: $todoData) , label: { Text("Add") })) // barItem 설정
            .listStyle(.inset)
            .navigationTitle("Todo-List")
            .cornerRadius(10.0)
            
            
        }
        .padding()
        
    }
       
    
    
    
    func delete(at offsets: IndexSet) { // 삭제 함수
        if let first = offsets.first {
            todoData.remove(at: first)
        }
    }
    
    func toggleCompleted(at index: Int) {
<<<<<<< Updated upstream
        todoData[index-1].completed.toggle()
    }
    
    
=======
        todoData[index].completed.toggle()
    } 
>>>>>>> Stashed changes
}



#Preview {
    ContentView()
}
