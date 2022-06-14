const mongoose = require("mongoose");

// nickname -> The user need to pass the nickname while creating or joining the room.
// socketID -> Every user that joins in has their own socketID which can be retrived as "socket.id"
// points -> Points will keep track of the user scored points.
// playerType -> playerType is what the user is playing as: "X" or "O"

const playerSchema = new mongoose.Schema({
  nickname: {
    type: String,
    trim: true,
  },
  socketID: {
    type: String,
  },
  points: {
    type: Number,
    default: 0,
  },
  playerType: {
    required: true,
    type: String,
  },
});

module.exports = playerSchema;