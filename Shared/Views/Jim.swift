import SwiftUI

// MARK: - ListView
struct JimList: View {
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
                        NavigationLink(destination: DetailView(name: n)) {
                            HStack {
                                VStack {
                                    ZStack {
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

