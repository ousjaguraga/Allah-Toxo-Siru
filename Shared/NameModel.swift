//
//  NameModel.swift
//  Allah Toxo Siru
//
//  Created by Ovenger on 28/01/2022.
//

import Foundation

struct NameModel:  Codable {
    
    var names = [Name]()
    
    struct Name: Identifiable, Hashable, Codable {
        var id: Int
        var name: [String]
        var arabic: String
        var touched: Bool
        var quran: String
        var translation: [String]
    }
    
    init (){}
    
    init(json: Data) throws {
        self = try JSONDecoder().decode(NameModel.self, from: json)
    }
    init(url: URL) throws {
        let data = try Data(contentsOf: url)
        self = try NameModel(json: data)
    }
    
   
    mutating func toggle_touched(_ id: Int){
        
       
        // make all the other cards touched to be false
        //for index in names.indices {
        //    names[index].touched = false
        //}
        
        // get the Name that was touched
        if let chosenIndex = names.firstIndex(where: {$0.id == id}){
            var chosenName = names[chosenIndex]
            chosenName.touched = !chosenName.touched
            
            names[chosenIndex] = chosenName
        }
        
    }
    
    func getNameWith(id theID: Int) -> String {
        print(names)
        let index = names.firstIndex(where: {$0.id == theID})!
        return names[index - 1].name[0]
    }
    
}
