const mongoose = require("mongoose");

const orderSchema = new mongoose.Schema({
  plants: [
    {
      _id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Plant",
        require: true,
      },
      quantity: {
        type: Number,
      },
    },
  ],
  email: {
    type: String,
    ref: "User",
    require: true,
  },
  total: {
    type: Number,
    default: 0,
  },
  /*1: pending, 0: canceled, 2: confirmed*/
  status: {
    type: Number,
    default: 1,
  },
  createdAt: {
    type: Date,
  },
});

module.exports = mongoose.model("Order", orderSchema);
