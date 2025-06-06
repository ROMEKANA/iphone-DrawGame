import SwiftUI

struct MatchingView: View {
    @State private var roomId: String = ""
    @State private var playerName: String = ""

    var body: some View {
        VStack(spacing: 20) {
            TextField("Your Name", text: $playerName)
                .textFieldStyle(.roundedBorder)
            TextField("Room ID", text: $roomId)
                .textFieldStyle(.roundedBorder)
            NavigationLink("Create Room") {
                DrawingView(roomId: UUID().uuidString, playerName: playerName, isHost: true)
            }
            NavigationLink("Join Room") {
                DrawingView(roomId: roomId, playerName: playerName, isHost: false)
            }
        }
        .padding()
        .navigationTitle("Match")
    }
}

#Preview {
    MatchingView()
}
