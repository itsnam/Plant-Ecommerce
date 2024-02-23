const express = require("express");
const router = express.Router();
const orderController = require("../controllers/orderController");

router.get("/:userEmail", orderController.getCurrentOrderByEmail);
router.post("/", orderController.addOrder);

module.exports = router;
