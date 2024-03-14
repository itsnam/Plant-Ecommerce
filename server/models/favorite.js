const mongoose = require("mongoose");

const favoriteSchema = new mongoose.Schema({
  plants: [
    {
      _id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Plant",
        require: true,
      },
    },
  ],
  email: {
    type: String,
    ref: "User",
    require: true,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model("Favorite", favoriteSchema);
