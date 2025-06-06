import SwiftUI

struct DrawingView: View {
    var roomId: String
    var playerName: String
    var isHost: Bool
    @StateObject private var socket = GameSocket()
    @State private var currentPath = Path()
    @State private var paths: [Path] = []

    var body: some View {
        VStack {
            Canvas { context, size in
                for path in paths {
                    context.stroke(path, with: .color(.black), lineWidth: 3)
                }
                context.stroke(currentPath, with: .color(.blue), lineWidth: 3)
            }
            .gesture(DragGesture(minimumDistance: 0.1)
                .onChanged { value in
                    currentPath.addLine(to: value.location)
                }
                .onEnded { _ in
                    paths.append(currentPath)
                    socket.sendDraw(path: currentPath)
                    currentPath = Path()
                }
            )
            .background(Color.white)
        }
        .onAppear {
            if isHost {
                socket.host(roomId: roomId, playerName: playerName)
            } else {
                socket.join(roomId: roomId, playerName: playerName)
            }
        }
        .navigationTitle(roomId)
    }
}

#Preview {
    DrawingView(roomId: "sample", playerName: "A", isHost: true)
}
