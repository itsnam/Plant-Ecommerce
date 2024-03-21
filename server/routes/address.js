const express = require("express");
const router = express.Router();
const addressController = require("../controllers/addressController");

router.post("/", addressController.addNewAddress);
router.get("/:email", addressController.getAddress);
router.delete("/:email/:addressId", addressController.deleteAddress);
router.put("/:email/:addressId", addressController.updateAddress);
module.exports = router;
