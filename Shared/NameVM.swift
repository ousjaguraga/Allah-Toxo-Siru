//
//  NameVM.swift
//  Allah Toxo Siru
//
//  Created by Ovenger on 28/01/2022.
//

import Foundation

class NameVM: ObservableObject {
    
    @Published private  var model = NameModel()
    
    
    var names: Array<NameModel.Name> {
        return model.names
    }
    
    init(){
        loadJson()
    }
    
    private func loadJson(){
        if let path = Bundle.main.path(forResource: "names", ofType: "json"){
            let url = URL(fileURLWithPath: path)
            model = try! NameModel(url: url)
        }
    }
    
    // Intents
    func touched(_ id: Int){
        model.touched(id)
    }
    
    
}
