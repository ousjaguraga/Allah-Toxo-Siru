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
    @State var first = true
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    let isPlayingTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()


    
    
    var body: some View {
        ZStack {
            SlideView
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
    
    
    var SlideView : some View {
        return TabView(selection: $selectedTab) {
            ForEach(names.indices, id: \.self) { index in
                
                if isAutoPlaying {
                    DetailTab(name:  names[selectedTab > 0 ? selectedTab-1 : selectedTab])
                        .tag(index+1)
                } else {
                    DetailView(name: names[selectedTab])
                        .tag(index)
                }
           }
        }
        .background(Color.backgroundOne)
        .edgesIgnoringSafeArea(.all)
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        
    }
}




// MARK: - Drawing Constants
struct DrawingConstants {
    static let borderColor: Color = .green
    static let scaleFactor: CGFloat = 0.079
}




#Preview {
    ContentView()
}

