import SwiftUI

// MARK: - ListView
struct MichaelList: View {
    var names: [NameModel.Name]
    @ObservedObject var nameVM: NameVM

    var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.islamicGold, Color.islamicGoldDark]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    let columnLayout = Array(repeating: GridItem(), count: 2)

    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columnLayout){
                    ForEach(names) { n in
                        NavigationLink(destination:SwipeableView(names: nameVM.names)) {
                            HStack {
                                VStack {
                                    ZStack {
                                        Circle()
                                            .fill(gradient)
                                            .shadow(color: .black, radius: 5, x: 0, y: 5)
                                            .frame(width: 110, height: 110)
                                        Text(n.arabic)
                                            .font(.largeTitle)
                                            .foregroundColor(Color.white)
                                    }
                                    Text(n.name[0].uppercased())
                                        .font(.subheadline)
                                }
                            }
                           
                        }
                        
                        .padding(.horizontal, 10)
                    }
                .padding(.vertical, 10)
            }
        }
        .background(Color.backgroundOne)
        .edgesIgnoringSafeArea(.bottom)
    }
}

