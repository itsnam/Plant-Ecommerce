const Plant = require('../models/plant');

const getAllPlants = async (req, res) => {
  try {
    const plants = await Plant.find();
    res.json(plants);
  }catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

module.exports = {getAllPlants}