const mongoose = require("mongoose");

const addressSchema = new mongoose.Schema({
  email: {
    type: String,
    ref: "User",
    require: true,
  },
  addresses: [
    {
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
  ],
});

module.exports = mongoose.model("Address", addressSchema);
