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

  // TODO 6: joinRoom method here

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