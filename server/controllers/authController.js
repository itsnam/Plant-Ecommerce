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

        await user.save();

        otp.sendOTP(email, OTP);
        res.status(200).send('OTP sent successfully');
    }catch (e) {
        console.log(e);
        res.status(500).send('Server error');
    }
}

const verifyOTPAndLogin = async (req, res) => {
    const { email, otpCode } = req.body;

    try {
        const user = await User.findOne({ email });

        if (!user) {
            return res.status(404).json({ message: 'Người dùng không tồn tại' });
        }

        if (user.OTP !== otpCode) {
            return res.status(400).json({ message: 'Mã OTP không hợp lệ' });
        }

        user.isLoggedIn = true;
        await user.save();

        return res.status(200).json({ message: 'Đăng nhập thành công' });
    } catch (error) {
        console.error('Lỗi đăng nhập:', error);
        return res.status(500).json({ message: 'Lỗi server' });
    }
}

const test = (req, res) => {
    res.status(200).send('hello');
}

module.exports = {generateOTP, test, verifyOTPAndLogin,}
