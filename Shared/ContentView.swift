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



struct SwipeableViewd: View {
    var names: [NameModel.Name]
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(names.indices, id: \.self) { index in
                DetailView(name: names[index])
            }
        }
        .background(Color.backgroundOne)
        .edgesIgnoringSafeArea(.all)
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}


struct SwipeableView: View {
    var names: [NameModel.Name]
    @State private var selectedTab = 0
    @State private var isAutoPlaying = false
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect() // Change 3 to desired interval

    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    ForEach(names.indices, id: \.self) { index in
                DetailView(name: names[index], isAutoPlaying: isAutoPlaying)
                            .tag(index)
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

extension NameModel.Name {
    static var SwipeablePreviewData: [NameModel.Name] {
        [
            NameModel.Name(id: 1, name: ["Name 1"], arabic: "اسم ١", touched: false),
            NameModel.Name(id: 1, name: ["Name 1"], arabic: "اسم ١", touched: false),
            NameModel.Name(id: 1, name: ["Name 1"], arabic: "اسم ١", touched: false),
           
        ]
    }
}


// MARK: - Previews
struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            SwipeableView(names: NameModel.Name.SwipeablePreviewData)
            ContentView()
                .preferredColorScheme(.dark)
            ContentView()
                .preferredColorScheme(.light)
          
        }
    }
}


