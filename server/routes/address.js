const express = require("express");
const router = express.Router();
const addressController = require("../controllers/addressController");

router.post("/", addressController.addNewAddress);
router.get("/:email", addressController.getAddress);
module.exports = router;
