# DrawGame

This repository contains a minimal prototype of a small online drawing game for iPhone/iPad.

## Structure

- `server/` - Node.js WebSocket server that manages rooms using a simple room ID system.
- `client/` - SwiftUI sample code for the iOS client.

## Running the Server

Install dependencies and start the server:

```bash
cd server
npm install
node server.js
```

The server listens on `ws://localhost:8080` and relays JSON messages between all clients in the same room.

## iOS Client

The SwiftUI code in `client/` shows a simple example of connecting to the server, creating or joining rooms, and drawing on a canvas. You can open the folder in Xcode and build it for iOS.

The client uses `URLSessionWebSocketTask` to communicate with the server. Drawing data is currently sent as a placeholder string and should be extended to send real stroke information.

## Development Notes

This is a small prototype meant to demonstrate the basic structure of a room-based drawing game. It is not production ready and lacks many features such as persistence, user authentication and proper game logic.

## Game Logic

The server now contains a very small implementation of the drawing and guessing
cycle. Rooms keep track of connected players and their scores. When the host
sends a `start` message a round begins:

1. One player is chosen as the drawer and receives a random prompt.
2. The drawer sends drawing data which is broadcast to the other players.
3. After finishing the drawing, the other players submit fake titles.
4. All titles plus the real prompt are sent back and players choose an answer.
5. Scores are updated and the next round automatically starts.

This logic is purposely lightweight and exists only on the server. The SwiftUI
client remains a simple prototype and will need to be extended to send the new
message types (`start`, `finish`, `title`, `answer`) and to present the UI for
the different steps of the game.
