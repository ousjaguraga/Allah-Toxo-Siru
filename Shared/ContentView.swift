// ContentView.swift
// Shared
// Created by Ovenger on 28/01/2022.

import SwiftUI

// MARK: - Main ContentView
struct ContentView: View {
    @ObservedObject var nameVM = NameVM()
   
    var body: some View {
        
        ZStack {
            VStack {
                Text("ALLA TOXO SIRU").foregroundColor(.accentColor).padding(50).font(.largeTitle)
                NavigationView {
                        MichaelList(names: nameVM.names, nameVM: nameVM)
                }
            }
        }
        .background(Color.backgroundOne).edgesIgnoringSafeArea(.all)
    }
}


struct SwipeableView: View {
    @ObservedObject var nameVM = NameVM()
    var names: [NameModel.Name]
    @State var selectedTab: Int
    @State private var isAutoPlaying = false
    @State  var player = Player()
    @State var isPlaying: Bool = false
    @State var first = true
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    let isPlayingTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()


    
    
    var body: some View {
        ZStack {
            VStack {
                
                TabView(selection: $selectedTab) {
                    
                    if (isAutoPlaying){
                        ForEach(names.indices, id: \.self) { index in
                            DetailTab(name: names[selectedTab > 0 ? selectedTab-1 : selectedTab], playAll: isAutoPlaying)
                                        .tag(index+1)
                        }
                    } else {
                        ForEach(names.indices, id: \.self) { index in
                         DetailView(name: names[selectedTab], playAll: isAutoPlaying)
                                        .tag(index)
                        }
                    }
                   
                }
                .background(Color.backgroundOne)
                .edgesIgnoringSafeArea(.all)
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            .onDisappear {
                isAutoPlaying = false
                player.stop()
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(Color.backgroundOne)
            
            .onReceive(isPlayingTimer) { _ in
                player = Player(id: selectedTab+1)
            }
            .onReceive(timer) { _ in
               
                if (isAutoPlaying){
                    player.togglePlay()
                    
                    selectedTab = (selectedTab + 1) % names.count
                }
            }
            VStack(alignment: .leading){
                Button(isAutoPlaying ? "Stop" : "Play All") {
                    isAutoPlaying.toggle()
                }
                Spacer()
            }
        }.padding(.bottom, -1).background(Color.backgroundOne)
    }
}


// BUG: - Bug with two names playing at once has to do with the id in the auto playing
// When debugging, less coding is better, i have been able to see light after stepping away
// SKIPS ID 1 and 2 . WHY?

// MARK: - Drawing Constants
struct DrawingConstants {
    static let borderColor: Color = .green
    static let scaleFactor: CGFloat = 0.079
}




#Preview {
    ContentView()
}

