const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

router.post('/generate-otp', authController.generateOTP);
router.post('/test', authController.test);

module.exports = router;

