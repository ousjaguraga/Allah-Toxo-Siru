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
                        MichaelList(nameVM: nameVM)
                }
            }
        }
        .background(Color.backgroundOne).edgesIgnoringSafeArea(.all)
    }
}


struct SwipeableView: View {
    @ObservedObject var nameVM: NameVM
    @State var selectedTab: Int
    @State private var isAutoPlaying = false
    @State  var player = Player()
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    let isPlayingTimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    @State var first: Bool = true

    
    
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
                
               }
               .onReceive(timer) { _ in
                   player = Player(id: selectedTab+1)
                   
                   if (isAutoPlaying){
                       if (first){
                           player = Player(id: selectedTab)
                           player.togglePlay()
                           print(selectedTab)
                           first = false
                       } else {
                           selectedTab = (selectedTab + 1) % nameVM.names.count
                           player.togglePlay()
                          
                       }
                   }
                  
               }
                VStack(alignment: .leading){
                    Button(isAutoPlaying ? "Stop" : "Play All") {
                    isAutoPlaying.toggle()
                    first = true
                }
                
                Spacer()
            }
        }
        .padding(.bottom, -1).background(Color.backgroundOne)
       
    }
    
    
    var SlideView : some View {
        return TabView(selection: $selectedTab) {
            ForEach(nameVM.names) { name in
                DetailView(name: name)
                    .tag(name.id)
                        .onTapGesture(count: 2, perform: {
                            withAnimation(.easeInOut(duration: 1.5)){
                                nameVM.touched(name.id)
                            }
                            
                        }).onDisappear {
                            if name.touched {
                            nameVM.touched(name.id)
                            }
                           
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

