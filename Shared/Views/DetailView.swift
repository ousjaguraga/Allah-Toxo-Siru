import SwiftUI

struct DetailView: View {
    var name: NameModel.Name
    @State var playAll: Bool = false
    // Gradient colors for background
    let gradientColors = Gradient(colors: [Color.green.opacity(0.7), Color.blue.opacity(0.7)])

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 12)
                
                // Applying gradient to the background
                shape.fill(LinearGradient(gradient: gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing))
                
                shape.strokeBorder(Color.green.opacity(0.7), lineWidth: 3)
                    .shadow(radius: 10)
                
                VStack(spacing: 20) {
                    ZStack {
                        Star(corners: 5, smoothness: 0.43)
                            .frame(width: min(geometry.size.width, geometry.size.width) * 0.223, height: min(geometry.size.width, geometry.size.width) * 0.223)
                            .foregroundColor(.green).padding()
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.8), lineWidth: 3)
                            .frame(width: geometry.size.width / 4.5, height: geometry.size.height / 4.5)
                            .shadow(radius: 5)
                        
                        Text(String(name.id))
                            .font(.system(size: geometry.size.width * 0.1))
                            .foregroundColor(.white)
                    }
                    
                    Text(name.arabic)
                        .font(.system(size: geometry.size.width * 0.2))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                    
                    PlayerView(id: name.id, playAll: playAll)
                    
                    ForEach(name.name) { name in
                        Text(name)
                            .font(.system(size: geometry.size.width * 0.08))
                            .foregroundColor(.white)
                        Divider()
                            .background(Color.white.opacity(0.7))
                            .padding(.vertical, 5)
                    }
                }
                //.padding(20)
            }
            .padding(20).padding(.vertical, 50)
            .cornerRadius(25)
            .shadow(radius: 15)
        }.background(Color.backgroundOne).edgesIgnoringSafeArea(.all)
    }
}


