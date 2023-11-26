//
//  todoData.swift
//  toyProject-TodoList
//
//  Created by 김명현 on 11/8/23.
//

import Foundation
import SwiftUI
//
//var todoData1: [Todo] = load("sample.json")

class Parsing {
    func load<T: Decodable>(_ filename: String) -> T {

        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
}
