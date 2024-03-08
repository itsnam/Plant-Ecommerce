const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  email: { unique: true, require: true, type: String },
  OTP: { type: String },
  OTPCreatedAt: { type: Date, default: Date.now },
  role: { type: Number, default: 0 },
  status: { type: Boolean, default: false },
  createdAt: { type: Date, default: Date.now },
});

module.exports = mongoose.model("User", userSchema);
