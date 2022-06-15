const mongoose = require("mongoose");
const playerSchema = require("./player");

// occupancy -> How many players are going to fit in this particular room.
// maxRounds -> How long is your game going to run after which we can stop the game, declare the winner and store both the users out of the room.
// currentRound -> To keep track of which round we're on the current game.
// players -> Players array will consits of all the players in the room and there defined schema "player.js".
// isJoin -> isJoing basically tells us whether the room is joinable or not. Like if the game is started between two users we don't want the third user to join the room and disturb our game.
// turn -> turn can be used to know whose turn is going on, or which user is playing right now.
// turnIndex -> turnIndex is basically keeping track of which user turn it is

const roomSchema = new mongoose.Schema({
  occupancy: {
    type: Number,
    default: 2,
  },
  maxRounds: {
    type: Number,
    default: 2,
  },
  currentRound: {
    required: true,
    type: Number,
    default: 1,
  },
  players: [playerSchema],
  isJoin: {
    type: Boolean,
    default: true,
  },
  turn: playerSchema,
  turnIndex: {
    type: Number,
    default: 0,
  },
});

const roomModel = mongoose.model("Room", roomSchema);
module.exports = roomModel;