//
//  ContentView.swift
//  toyProject-TodoList
//
//  Created by 김명현 on 11/8/23.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(todoData, id: \.id) { data in
                    NavigationLink(destination: DetailView(todo: data)) {
                        Text(data.title)
                            .font(.headline)
                    }
                    
                }
            }
        }
        .padding()
    }
}






#Preview {
    ContentView()
}
