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
    @FetchRequest( // Core Data 가져오기 요청
        entity: TodoItem.entity(), // 사용할 엔티티
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoItem.todoId, ascending: true)] // 정렬 조건
    ) var todoItems: FetchedResults<TodoItem> // FetchedResults로 데이터를 받는다
    
    @State private var editMode: EditMode = .inactive
    
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
                .onDelete(perform: delete) // 삭제 기능 삽입
                .onMove(perform: move)
            }
            .navigationBarItems(leading: EditButton(), trailing: NavigationLink(destination: AddView() , label: { Text("Add") })) // barItem 설정
            .listStyle(.inset)
            .navigationTitle("Todo-List")
            .environment(\.editMode, $editMode)
            
        }
        .padding()
    }
    
    func delete(at offsets: IndexSet) { // 삭제 함수
        for index in offsets {  // 질문 : 함수를 실행 할 때 offsets에 어떤게 들어오는지 모르겠습니다.
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
        // 처음에 순서 수정 안 됐던 이유 : FetRequet 정렬 순서를 TodoItem.todoTitle로 해놔서 안됐음 -> TodoItem.todoId로 변경
        
        var revisedItems = todoItems.map { $0 }
        revisedItems.move(fromOffsets: source, toOffset: destination)
        
        // 각각의 위치를 다시 저장합니다.
        for index in revisedItems.indices {
            revisedItems[index].todoId = Int16(index)
        }
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}



//#Preview {
//    ContentView()
//}
