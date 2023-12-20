import SwiftUI

// MARK: - PlayerView
struct PlayerView: View {
    var id: Int
    @ObservedObject var player: Player
    @State var isPlaying: Bool = false
    // 0.01
    @State var timer = Timer.publish(every: 0.01,  on: .main, in: .common).autoconnect()

    
    init(id myID: Int){
        self.id = myID
        player = Player(id: id)
    }
   
  
    
    var body: some View {
        VStack {
            Button(action: { player.togglePlay() }) {
                Image(systemName: isPlaying ? "stop.fill" : "play.fill")
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
        .onReceive(timer) { _ in
            isPlaying = player.isPlaying
        }
    }
}
