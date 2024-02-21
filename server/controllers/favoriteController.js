const Favorite = require('../models/Favorite');

const addToFavorites = async (req, res) => {
  try {
    const { userEmail, plantId } = req.body;

    const existingFavorite = await Favorite.findOne({ userEmail, plantId });
    if (existingFavorite) {
      await Favorite.findOneAndDelete({ userEmail, plantId });
      return res.status(200).send('This plant is already in favorites. It has been removed.');
    }

    const favorite = new Favorite({
      userEmail,
      plantId
    });

    await favorite.save();

    res.status(201).send('Plant added to favorites successfully');

  } catch (e) {
    console.log(e);
    res.status(500).send('Server error');
  }
};

const getFavoritesByUserEmail = async (req, res) => {
  try {
    const { userEmail } = req.params;

    const favorites = await Favorite.find({ userEmail }).populate('plantId');

    res.status(200).json(favorites);
  } catch (e) {
    console.log(e);
    res.status(500).send('Server error');
  }
};


module.exports = {addToFavorites, getFavoritesByUserEmail}