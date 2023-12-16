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
    @State private var selectedTab = 0
    @State private var isAutoPlaying = false
    @State var playAll = false
    @State  var name: Int
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect() // Change 3 to desired interval

    var body: some View {
        ZStack {
            VStack {
                
                TabView(selection: $selectedTab) {
                    if (isAutoPlaying){
                        ForEach(names.indices, id: \.self) { index in
                         DetailView(name: names[index], playAll: playAll)
                                        .tag(index)
                        }
                    } else {
                        
                            DetailView(name: names[name-1], playAll: false)
                                      
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



// MARK: - Drawing Constants
struct DrawingConstants {
    static let borderColor: Color = .green
    static let scaleFactor: CGFloat = 0.079
}




#Preview {
    ContentView()
}

