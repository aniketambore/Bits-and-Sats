// Importing modules
const express = require("express");
const http = require("http");
const mongoose = require("mongoose");

const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);

var io = require("socket.io")(server);

// Middleware
app.use(express.json());

const DB = "";

// TODO: io connection implementation
io.on("connection", (socket) => {
  console.log("[+] Connected !");

  
  socket.on("createRoom", async ({nickname}) => {
    console.log(`[+] Accepted nickname is ${nickname}`);
    // TODO 4: Create Room Socket
    // TODO 5: Store player in the room
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