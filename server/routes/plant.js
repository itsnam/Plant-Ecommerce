const express = require("express");
const router = express.Router();
const plantController = require("../controllers/plantController");

router.post("/", plantController.upload, plantController.createPlant);

module.exports = router;
