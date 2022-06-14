// Importing modules
const express = require("express");
const http = require("http");
const mongoose = require("mongoose");

const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
const Room = require("./models/room");

var io = require("socket.io")(server);

// Middleware
app.use(express.json());

const DB = "";


io.on("connection", (socket) => {
  console.log("[+] Connected !");

  
  socket.on("createRoom", async ({nickname}) => {
    console.log(`[+] Accepted nickname is ${nickname}`);

    try {
      // room is created
      let room = new Room();
      let player = {
        socketID: socket.id,
        nickname,
        playerType: "X",
      };
      room.players.push(player);
      room.turn = player;
      room = await room.save();
      console.log(`[+] Current room is ${room}`);

      const roomId = room._id.toString();
      socket.join(roomId);
      
      // io -> send data to everyone
      // socket -> sending data to yourself
      io.to(roomId).emit("createRoomSuccess", room);
    } catch (e) {
      console.log(`[!] Error is ${e}`);
    }

  });

  socket.on("joinRoom", async ({ nickname, roomId }) => {

    try {
      // Checking if roomId is a proper mongoose id or not.
      if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit("errorOccurred", "Please enter a valid room ID.");
        return;
      }

      let room = await Room.findById(roomId);

      if (room.isJoin) {
        let player = {
          nickname,
          socketID: socket.id,
          playerType: "O",
        };
        socket.join(roomId);
        room.players.push(player);
        room.isJoin = false;
        room = await room.save();
        io.to(roomId).emit("joinRoomSuccess", room);
        io.to(roomId).emit("updatePlayers", room.players);
        io.to(roomId).emit("updateRoom", room);
      } else {
        socket.emit(
          "errorOccurred",
          "The game is in progress, please try again later."
        );
      }
    } catch (e) {
      console.log(`[!] Error is ${e}`);
    }

  });

  // TODO: "tap" socket
  socket.on("tap", async ({ index, roomId }) => {
    try {
      let room = await Room.findById(roomId);
      let choice = room.turn.playerType; // X or O

      if (room.turnIndex == 0) {
        room.turn = room.players[1];
        room.turnIndex = 1;
      } else {
        room.turn = room.players[0];
        room.turnIndex = 0;
      }

      room = await room.save();
      io.to(roomId).emit("tapped", {
        index,
        choice,
        room,
      });
    } catch (e) {
      console.log(`[!] Error is ${e}`);
    }

  });

  // TODO: Winner socket
  socket.on("winner", async ({ winnerSocketId, roomId }) => {
    try {
      let room = await Room.findById(roomId);
      let player = room.players.find(
        (playerr) => playerr.socketID == winnerSocketId
      );
      player.points += 1;
      room = await room.save();

      if (player.points >= room.maxRounds) {
        io.to(roomId).emit("endGame", player);
      } else {
        io.to(roomId).emit("pointIncrease", player);
      }
    } catch (e) {
      console.log(`[!] Error is ${e}`);
    }
  });

});

mongoose
  .connect(DB)
  .then(() => {
    console.log("[+] Connection Successful !");
  })
  .catch((e) => {
    console.log(`[!] Error is ${e}`);
  });

server.listen(port, "0.0.0.0", () => {
    console.log(`[+] Server started and running on port ${port}`);
  });