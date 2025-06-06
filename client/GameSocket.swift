import Foundation
import SwiftUI

class GameSocket: ObservableObject {

    private let peer = MultipeerSession()

    func host(roomId: String, playerName: String) {
        peer.startHosting(roomId: roomId)
    }

    func join(roomId: String, playerName: String) {
        peer.join(roomId: roomId)
    }

    func sendDraw(path: Path) {
        // send placeholder data for demo
        if let data = "draw".data(using: .utf8) {
            peer.send(data: data)
        }
    }
}
