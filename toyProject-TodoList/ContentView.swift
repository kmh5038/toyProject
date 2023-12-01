//
//  ContentView.swift
//  toyProject-TodoList
//
//  Created by 김명현 on 11/8/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: TodoItem.entity(), // 사용할 엔티티
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoItem.todoTitle, ascending: true)] // 정렬 조건
    ) var todoItems: FetchedResults<TodoItem> // FetchedResults로 데이터를 받습니다.
    
    var body: some View {
        NavigationStack { // 네비게이션이 중첩이 안된거같은데 못찾겠습니다 ㅠㅠ
            List{
                ForEach(todoItems, id: \.self) { todoItem in
                    HStack {
                        Button(action: {
                            toggleCompleted(todoItem)
                        }, label: {
                            Image(systemName: todoItem.todoCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                        })
                        .buttonStyle(PlainButtonStyle())
                        // 버튼이 안눌러짐 : row에 같은 탭 제스처를 수신하는 View 두개가 있는 경우에 이를 독립적으로 인식하지 않고 동시 작동된다. 이를 해결하기 위해서 버튼스타일을 별도로 지정해서 독립시킨다.
                        
                        NavigationLink(destination: DetailView(todoItem: todoItem)) {
                            Text(todoItem.todoTitle ?? "Untitled")
                                .font(.headline)
                        }
                    }
                }
                .onDelete(perform: delete) // 삭제 기능 삽입 (함수를 호출했는데 왜 delte()를 안해줘도 되는것인가?)
                .onMove(perform: move)
            }
            .navigationBarItems(leading: EditButton(), trailing: NavigationLink(destination: AddView() , label: { Text("Add") })) // barItem 설정
            .listStyle(.inset)
            .navigationTitle("Todo-List")
        }
        .padding()
    }
    
    func delete(at offsets: IndexSet) { // 삭제 함수
        for index in offsets {
            let todoItem = todoItems[index]
            viewContext.delete(todoItem)
        }
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func toggleCompleted(_ todoItem: TodoItem) {
        todoItem.todoCompleted.toggle()
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        var revisedItems: [TodoItem] = todoItems.map { $0 }
        revisedItems.move(fromOffsets: source, toOffset: destination)
        
        for reverseIndex in stride(from: revisedItems.count - 1, through: 0, by: -1) {
            revisedItems[reverseIndex].order = Int16(reverseIndex)
        }
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

}



#Preview {
    ContentView()
}
