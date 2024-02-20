const nodemailer = require('nodemailer');

const generateOTP = () => {
    return Math.floor(100000 + Math.random() * 900000).toString();
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

