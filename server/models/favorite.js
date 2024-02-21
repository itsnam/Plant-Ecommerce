const mongoose = require("mongoose");

const favoriteSchema = new mongoose.Schema({
  userEmail: {
    type: String,
    required: true
  },
  plantId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Plant',
    required: true
  },
  favoriteCreatedTime: {
    type: Date,
    default: Date.now
  },
});

module.exports = mongoose.model('Favorite', favoriteSchema);
