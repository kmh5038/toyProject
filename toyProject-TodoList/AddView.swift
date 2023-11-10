//
//  addView.swift
//  toyProject-TodoList
//
//  Created by 김명현 on 11/10/23.
//

import SwiftUI

struct AddView: View {
    
    @State private var titleTextField = ""
    @State private var scheduleTextEditor = ""
    
    
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
                   
                }
                
                .font(.title2)
                .kerning(1)
                .disabled(titleTextField.isEmpty || scheduleTextEditor.isEmpty ? true : false)
            }
            
          
        }
        .navigationTitle("Add Schedule")
        
            
    }
    

}

#Preview {
    AddView()
}
