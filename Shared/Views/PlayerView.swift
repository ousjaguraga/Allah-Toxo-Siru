import SwiftUI

// MARK: - PlayerView
struct PlayerView: View {
    var id: Int
    @State var playAll: Bool = false
    @ObservedObject var player: Player
    @State var isPlaying: Bool = false
    @State var timer = Timer.publish(every: 0.01,  on: .main, in: .common).autoconnect()
    
    init(id myID: Int, playAll autoPlayStatus: Bool){
        self.id = myID
        self.playAll = autoPlayStatus
        player = Player(id: id)
    }
    
    var body: some View {
        VStack {
            Button(action: { player.togglePlay() }) {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
        .onAppear{
            if (isPlaying){
                player.stop()
            }
            if (playAll){
                player.stop()
                player.togglePlay()
            }
           
        }
        .onReceive(timer) { _ in
            isPlaying = player.player.isPlaying
        }
    }
}
