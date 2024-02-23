const mongoose = require("mongoose");

const plantSchema = new mongoose.Schema({
  name: {
    type: String,
  },
  image: {
    type: String,
  },
  description: {
    type: String,
  },
  type: {
    type: String,
  },
  status: {
    type: Number,
    default: 1,
  },
  quantity: {
    type: Number,
  },
  price: {
    type: Number,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
  sold: {
    type: Number,
    default: 0,
  },
});

module.exports = mongoose.model("Plant", plantSchema);
