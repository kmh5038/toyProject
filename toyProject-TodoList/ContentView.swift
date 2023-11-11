//
//  ContentView.swift
//  toyProject-TodoList
//
//  Created by 김명현 on 11/8/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showCompleted = false
    @State private var todoData: [Todo] = load("sample.json") // Edit모드에서 삭제 적용이 안돼서 전역변수에서 여기로 옮김
    
    
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(todoData, id: \.id) { data in
                    HStack {
                        Button(action: { // 버튼이 안눌러짐
                            data.completed == true ? false : true
                        }, label: {
                            Image(systemName: data.completed ? "checkmark.circle.fill" : "checkmark.circle")
                        })
                       
                        NavigationLink(destination: DetailView(todo: data)) {
                            Text(data.title)
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
            .cornerRadius(10.0)
            
            
        }
        .padding()
    }
    
    
    func delte(at offsets: IndexSet) { // 삭제 함수
        if let first = offsets.first {
            todoData.remove(at: first)
        }
    }
    
    func toggleCompleted(at index: Int) {
        todoData[index].completed.toggle()
    }
    
    
}



#Preview {
    ContentView()
}