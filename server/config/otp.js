const nodemailer = require('nodemailer');
const crypto = require('crypto');

const generateOTP = () => {
    return crypto.randomBytes(3).toString('hex')
}

const sendOTP = (email, OTP) => {
    const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
            user: "plantial.auth@gmail.com",
            pass: "rtiv wzzz bijq suqs"
        }
    })

    const mailOptions = {
        from : "plantial.auth@gmail.com",
        to: email,
        subject: 'Your OTP',
        text: `Your OTP is: ${OTP}`,
    }

    transporter.sendMail(mailOptions, (error, info) => {
        if(error){
            console.log(error)
        }else{
            console.log("Email sent: " + info.response);
        }
    })
}

module.exports = {generateOTP, sendOTP}

