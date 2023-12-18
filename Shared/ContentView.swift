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
    //@State var autoplayer = Player(id: 0)
    
    let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            VStack {
                
                TabView(selection: $selectedTab) {
                    if (isAutoPlaying){
                        
                        ForEach(names.indices, id: \.self) { index in
                         DetailView(name: names[index], playAll: isAutoPlaying)
                                        .tag(index)
                        }
                    } else {
                        // name: names[name+selectedTab-1]
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
            .edgesIgnoringSafeArea(.bottom)
            .background(Color.backgroundOne)
            
            .onReceive(timer) { _ in
                if isAutoPlaying {
                    withAnimation {
                        selectedTab = (selectedTab + 1) % names.count
                    }
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

