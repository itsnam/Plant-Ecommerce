const express = require("express");
const otp = require("../config/otp");
const User = require("../models/user");

const generateOTP = async (req, res) => {
  const email = req.body.email;

  try {
    let user = await User.findOne({ email: email });
    if (!user) {
      user = new User({ email: email });
    }

    const OTP = otp.generateOTP();
    user.OTP = OTP;

    user.OTPCreatedAt = new Date();

    await user.save();

    otp.sendOTP(email, OTP);
    res.status(200).send("OTP sent successfully");
  } catch (e) {
    console.log(e);
    res.status(500).send("Server error");
  }
};

const verifyOTPAndLogin = async (req, res) => {
  const { email, OTP } = req.body;

  try {
    const user = await User.findOne({ email });

    if (!user) {
      return res.status(404).send("User not found");
    }

    if (user.OTP !== OTP) {
      return res.status(400).send("OTP không hợp lệ");
    }

    const OTP_EXPIRATION_TIME = 5 * 60 * 1000;
    const currentTime = new Date();
    const timeDifference = currentTime - user.OTPCreatedAt;

    if (timeDifference > OTP_EXPIRATION_TIME) {
      return res.status(400).send("OTP đã hết hạn");
    }

    res.status(200).send("Login successful");
  } catch (e) {
    console.log(e);
    res.status(500).send("Server error");
  }
};

const test = (req, res) => {
  res.status(200).send("hello");
};

module.exports = { generateOTP, test, verifyOTPAndLogin };
