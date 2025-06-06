const WebSocket = require('ws');
const wss = new WebSocket.Server({ port: 8080 });

const rooms = {};

function broadcast(roomId, data) {
  const room = rooms[roomId];
  if (!room) return;
  const message = JSON.stringify(data);
  room.forEach(client => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(message);
    }
  });
}

wss.on('connection', ws => {
  ws.on('message', message => {
    let data;
    try { data = JSON.parse(message); } catch (err) { return; }

    if (data.type === 'join') {
      const roomId = data.roomId;
      if (!rooms[roomId]) rooms[roomId] = [];
      rooms[roomId].push(ws);
      ws.roomId = roomId;
      broadcast(roomId, { type: 'system', msg: `${data.name} joined` });
    } else {
      const roomId = ws.roomId;
      if (!roomId) return;
      broadcast(roomId, data);
    }
  });

  ws.on('close', () => {
    const roomId = ws.roomId;
    if (!roomId) return;
    rooms[roomId] = rooms[roomId].filter(c => c !== ws);
  });
});

console.log('WebSocket server running on ws://localhost:8080');
