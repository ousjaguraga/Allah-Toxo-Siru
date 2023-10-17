// ContentView.swift
// Shared
// Created by Ovenger on 28/01/2022.

import SwiftUI

// MARK: - Main ContentView
struct ContentView: View {
    
    @ObservedObject var nameVM = NameVM()
    
    var body: some View {
        
        VStack {
            Text("ALLA TOXO SIRU")
                .font(.title)
            NavigationView {
                ListView(names: nameVM.names, nameVM: nameVM)
            }
        }
    }
}

// MARK: - ListView
struct ListView: View {
    var names: [NameModel.Name]
    @ObservedObject var nameVM: NameVM
    
    var body: some View {
        
        if #available(iOS 16.0, *) {
            List(names) { n in
                NavigationLink(destination: DetailView(name: n)) {
                    Text(String(n.id))
                        .font(.caption)
                    Text(n.name[0].uppercased())
                    Text(n.arabic)
                        .font(.headline)
                  }
               }
            .scrollContentBackground(.hidden)
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
         
            
        } else {
            List(names) { n in
                NavigationLink(destination: DetailView(name: n)) {
                    Text(String(n.id))
                        .font(.caption)
                    Text(n.name[0].uppercased())
                    Text(n.arabic)
                        .font(.headline)
                  }
               }
                 .listStyle(.plain)
        }
          
           
            
    }
}



// MARK: - DetailView
struct DetailView: View {
    var name: NameModel.Name
    var body: some View {
            GeometryReader { geometry in
                ZStack {
                    let shape = RoundedRectangle(cornerRadius: 12)
                   
                    shape.fill(name.touched ?  .primaryLight : Color.accentColor)
                    shape.strokeBorder(lineWidth: 3).foregroundColor(.green).cornerRadius(12)
                    VStack {
                        
                        ZStack {
                            
                            Star(corners: 5, smoothness: 0.43).frame(width: min(geometry.size.width , geometry.size.width) * 0.223, height: min(geometry.size.width , geometry.size.width) * 0.223)
                                .foregroundColor(.green)
                            
                            Circle().strokeBorder(.white).frame(width: geometry.size.width / 4.3, height: geometry.size.height / 4.3)
                            
                           
                            Text(String(name.id)).font(.system(size: min(geometry.size.width, geometry.size.height) * DrawingConstants.scaleFactor))
                        }
                        Spacer()
                        Text(name.arabic).font(.system(size: min(geometry.size.width, geometry.size.height) * 0.26)).foregroundColor(.green)
                        PlayerView(id: name.id)
                        Spacer()
                        
                        ForEach(name.name){ name in
                            
                            Text(name).font(.system(size: min(geometry.size.width, geometry.size.height) * DrawingConstants.scaleFactor))
                            Divider().background(Color.white).padding(.top, 0)
                            
                        }
                          .foregroundColor(.white)
                    }.padding()
                        
                    
                }
            }
            
        }
}

// MARK: - PlayerView
struct PlayerView: View {
    var id: Int
    @ObservedObject var player: Player
    @State var isPlaying: Bool = false
    @State var timer = Timer.publish(every: 0.01,  on: .main, in: .common).autoconnect()
    
    init(id myID: Int){
        self.id = myID
        player = Player(id: id)
    }
    
    var body: some View {
        VStack {
            Button(action: { player.togglePlay() }) {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
        .onReceive(timer) { _ in
            isPlaying = player.player.isPlaying
        }
    }
}

// MARK: - Drawing Constants
struct DrawingConstants {
    static let borderColor: Color = .green
    static let scaleFactor: CGFloat = 0.079
}

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

