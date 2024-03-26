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
  /*1: default, 0: canceled, 2: pending, 3: confirmed*/
  status: {
    type: Number,
    default: 1,
  },
  createdAt: {
    type: Date,
  },
  paymentMethod: {
    type: String,
  },
  address: {
    phone: {
      type: String,
    },
    name: {
      type: String,
    },
    street: {
      type: String,
    },
    ward: {
      type: [String],
    },
    district: {
      type: [String],
    },
    province: {
      type: [String],
    },
  },
});

module.exports = mongoose.model("Order", orderSchema);
