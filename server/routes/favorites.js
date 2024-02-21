const express = require('express');
const router = express.Router();
const favoriteController = require('../controllers/favoriteController');

router.post('/add', favoriteController.addToFavorites);
router.get('/:userEmail', favoriteController.getFavoritesByUserEmail);

module.exports = router;