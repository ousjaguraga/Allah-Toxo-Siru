import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    @State private var animatePattern = false

    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color.backgroundOne.edgesIgnoringSafeArea(.all)
                Text("‎اللَّهُ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                // Pulsating Pattern Animation
                    PulsatingPatternView(animate: $animatePattern)
                        .frame(width: 200, height: 200)
                        .onAppear() {
                            withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                                self.animatePattern = true
                            }
                        }
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct PulsatingPatternView: View {
    @Binding var animate: Bool

    var body: some View {
        ZStack {
            ForEach(0..<3) { i in
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.islamicGold)
                    .scaleEffect(animate ? 3 : 1)
                    .opacity(animate ? 0 : 1)
                    .animation(Animation.easeInOut(duration: 1).delay(Double(i) * 0.3).repeatForever(autoreverses: false), value: animate)
            }
        }
    }
}


#Preview {
    SplashView()
}
