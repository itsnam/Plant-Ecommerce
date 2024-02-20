const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    email: {unique: true, require: true, type: String,},
    OTP: {type: String,},
    OTPCreatedTime: {type: Date, default: Date.now,},
    isBlocked: {type: Boolean, default: false},
})

module.exports = mongoose.model('User', userSchema);
