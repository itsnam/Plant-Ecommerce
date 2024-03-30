const express = require("express");
const router = express.Router();
const plantController = require("../controllers/plantController/plantController");
const uploadToLocal = require("../controllers/plantController/uploadToLocal");
const uploadToMemory = require("../controllers/plantController/uploadToMemory");

router.get("/", plantController.getPlants);
router.get("/:_id", plantController.getPlantById);
router.post("/", uploadToLocal, plantController.createPlant);
router.post("/predict", uploadToMemory, plantController.predict);
router.put("/", uploadToLocal, plantController.updatePlant);
router.post("/search", plantController.search);

module.exports = router;
