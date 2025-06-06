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

The server listens on `ws://localhost:8080` and relays JSON messages between all clients in the same room. You can skip running the server if you use the new peer-to-peer mode in the iOS client.

## iOS Client

The SwiftUI code in `client/` shows a simple example of connecting to the server, creating or joining rooms, and drawing on a canvas. You can open the folder in Xcode and build it for iOS.

The client originally used WebSockets, but a simple peer-to-peer mode is now included using Apple's `MultipeerConnectivity` framework. When a player creates a room they act as the host and advertise the session on the local network. Other players join the room without the Node.js server.

Drawing data is still sent as placeholder strings and should be extended to transmit real stroke information.

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

## Basic Scenes

The iOS client now contains minimal SwiftUI views that outline the game flow:

1. **TitleView** – shows the game title and a button to start.
2. **MatchingView** – enter a player name and room ID to create or join a room.
3. **DrawingView** – simple canvas where the drawer sketches the prompt.
4. **TitleInputView** – other players enter fake titles after the drawing.
5. **ChoiceView** – everyone chooses from the list of titles.
6. **ResultView** – displays placeholder results before the next round.

These screens are linked with `NavigationLink` so you can tap through the flow
even though the networking and game logic are still very limited.
