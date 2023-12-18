import SwiftUI

// MARK: - PlayerView
struct PlayerView: View {
    var id: Int
    @State var playAll: Bool = false
    @ObservedObject var player: Player
    @State var isPlaying: Bool = false
    // 0.01
    @State var timer = Timer.publish(every: 0.1,  on: .main, in: .common).autoconnect()
    
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
        .onReceive(timer) { _ in
            isPlaying = player.player.isPlaying
        }.onAppear {
            if (playAll){
                player.togglePlay()
                
            }
        }
    }
}
