const Favorite = require('../models/Favorite');

exports.addToFavorites = async (req, res) => {
  try {
    const { email, productId } = req.body;

    const favorite = await Favorite.findOne({ email });
    if (!favorite) {
      const newFavorite = new Favorite({
        email,
        plants: [{ _id: productId }],
      });
      await newFavorite.save();
      return res.status(201).json(newFavorite);
    }

    const index = favorite.plants.findIndex(plant => plant._id.toString() === productId);
    if (index === -1) {
      favorite.plants.push({ _id: productId });
      await favorite.save();
      return res.status(201).json(favorite);
    } else {
      favorite.plants.splice(index, 1);
      await favorite.save();
      return res.status(200).json(favorite);
    }
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: "Internal server error" });
  }
};



exports.getFavoritesByUserEmail = async (req, res) => {
  const { userEmail } = req.params;
  const favorite = await Favorite.findOne({ email: userEmail }).populate(
    "plants._id",
  );
  if (favorite) {
    return res.status(200).json(favorite);
  }
  return res.status(404).json("Favourite empty");
};

