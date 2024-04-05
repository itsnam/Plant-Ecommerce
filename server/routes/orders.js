const express = require("express");
const router = express.Router();
const orderController = require("../controllers/orderController");

router.get("/:userEmail", orderController.getCurrentOrderByEmail);
router.get('/', orderController.getAllOrders);
router.post("/", orderController.addOrder);
router.put("/:email", orderController.sendOrderRequest);
router.put("/", orderController.updateOrder);
router.get("/history/:userEmail", orderController.getHistoryOrderByEmail);
router.get('/get/:_id', orderController.getCurrentOrderById);

module.exports = router;
