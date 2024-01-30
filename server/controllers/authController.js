const express = require('express');
const otp = require('../config/otp');
const User = require('../models/user')

const generateOTP = async (req, res) => {
    const email = req.body.email;

    try {
        let user = await User.findOne({email: email});
        if (!user) {
            user = new User({email: email});
        }

        const OTP = otp.generateOTP();
        user.OTP = OTP;

        await  user.save();

        otp.sendOTP(email, OTP);
        res.status(200).send('OTP sent successfully');
    }catch (e) {
        console.log(e);
        res.status(500).send('Server error');
    }
}

const test = (req, res) => {
    res.status(200).send('hello');
}
module.exports = {generateOTP, test}
