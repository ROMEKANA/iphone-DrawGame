import Foundation
import SwiftUI

class GameSocket: ObservableObject {
    private var socket: URLSessionWebSocketTask?
    private let url = URL(string: "ws://localhost:8080")!

    func connect(roomId: String, playerName: String) {
        let session = URLSession(configuration: .default)
        socket = session.webSocketTask(with: url)
        socket?.resume()
        send(json: ["type": "join", "roomId": roomId, "name": playerName])
        receive()
    }

    func sendDraw(path: Path) {
        // Just send a placeholder message for demo
        send(json: ["type": "draw", "data": "path"])
    }

    private func send(json: [String: Any]) {
        guard let socket else { return }
        let data = try? JSONSerialization.data(withJSONObject: json)
        if let data {
            socket.send(.data(data)) { error in
                if let error = error {
                    print("send error", error)
                }
            }
        }
    }

    private func receive() {
        socket?.receive { [weak self] result in
            switch result {
            case .success(let message):
                print("received", message)
            case .failure(let error):
                print("receive error", error)
            }
            self?.receive()
        }
    }
}
