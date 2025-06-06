import SwiftUI

struct DrawingView: View {
    var roomId: String
    var playerName: String
    var isHost: Bool
    @StateObject private var socket = GameSocket()
    @State private var currentPath = Path()
    @State private var paths: [Path] = []

    @State private var timeRemaining = Int(GameConfig.drawingTime)
    @State private var autoNext = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("Time: \(timeRemaining)")
                .font(.headline)
                .padding(.top)

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


            NavigationLink("Finish Drawing") {
                TitleInputView()
            }
            NavigationLink("", destination: TitleInputView(), isActive: $autoNext) {
                EmptyView()
            }
        }
        .onAppear {
            if isHost {
                socket.host(roomId: roomId, playerName: playerName)
            } else {
                socket.join(roomId: roomId, playerName: playerName)
            }
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                autoNext = true
            }

        }
        .navigationTitle(roomId)
    }
}

#Preview {
    DrawingView(roomId: "sample", playerName: "A", isHost: true)
}
