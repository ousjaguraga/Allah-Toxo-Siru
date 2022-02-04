//
//  Player.swift
//  Allah Toxo Siru
//
//  Created by Ovenger on 03/02/2022.
//

import Foundation
import AVKit


class Player: ObservableObject {
    @Published  var player = AVAudioPlayer()
    
    // empty init
    init(){}
    
    // play audio witg ID given
    init(id: Int){
        
        if let url = Bundle.main.url(forResource: "\(id)", withExtension: "mp3"){
            do {
                let data = try! Data(contentsOf: url)
                player = try AVAudioPlayer(data: data)
                player.prepareToPlay()
               
               
            } catch {
                print("Error")
            }
            
        }
    }
    
   func play(){
        player.play()
    }
}
