const Order = require("../models/order");
const Plant = require("../models/plant");
const { ObjectId, Types } = require("mongoose");

exports.getCurrentOrderByEmail = async (req, res) => {
  const { userEmail } = req.params;
  const order = await Order.findOne({ email: userEmail, status: 1 }).populate(
    "plants._id",
  );
  if (order) {
    return res.status(200).json(order);
  }
  return res.status(404).json("Cart empty");  
};

const updatePlant = async (order, data) => {
  const p = order.plants.filter((obj) => obj._id.toString() === data.productId);
  if (p.length > 0) {
    const q = p[0].quantity + data.quantity;
    await Order.findOneAndUpdate(
      { email: data.email, status: 1, "plants._id": data.productId },
      {
        $set: {
          "plants.$.quantity": q,
        },
      },
    );
  } else {
    const plant = {
      _id: data.productId,
      quantity: data.quantity,
    };
    await Order.findOneAndUpdate(
      { email: data.email, status: 1 },
      {
        $push: { plants: plant },
      },
    );
  }
};

exports.addOrder = async (req, res) => {
  try {
    const data = req.body;
    const order = await Order.findOne({ email: data.email, status: 1 });
    if (!order) {
      const order = new Order({
        email: data.email,
      });
      await order.save();
      await updatePlant(order, data);
    } else {
      await updatePlant(order, data);
    }

    return res.status(200).json("add to cart");
  } catch (e) {
    console.log(e);
  }
};

const updatePlantQuantity = async (plantList) => {
  for (const item of plantList) {
    let plant = await Plant.findOne({
      _id: item._id,
      status: 1,
      quantity: { $gt: 0 },
    });
    plant.quantity -= item.quantity;
    await plant.save();
  }
};

exports.updateOrder = async (req, res) => {
  try {
    const data = req.body;
    const cartItems = data.cartItems;
    const email = data.email;
    const order = await Order.findOne({ email: email, status: 1 });
    if (order) {
      plants = [];
      cartItems.map((item) => {
        plants.push({
          _id: new Types.ObjectId(item.product._id),
          quantity: item.quantity,
        });
      });
      order.plants = plants;
      await order.save();
    }
  } catch (e) {}
};

exports.sendOrderRequest = async (req, res) => {
  try {
    const email = req.params.email;
    const order = await Order.findOne({ email: email, status: 1 });
    const { address, paymentMethod, total } = req.body;
    if (order) {
      order.paymentMethod = paymentMethod.name;
      order.total = total;
      order.address.name = address.name;
      order.address.phone = address.phone;
      order.address.street = address.street;
      order.address.district = JSON.parse(address.district.replace(/'/g, '"'));
      order.address.province = JSON.parse(address.province.replace(/'/g, '"'));
      order.address.ward = JSON.parse(address.ward.replace(/'/g, '"'));
      await updatePlantQuantity(order.plants);
      order.status = 2;
      await order.save();
    }

  } catch (e) {
    console.log(e);
  }
};

exports.getHistoryOrderByEmail = async (req, res) => {
  const { userEmail } = req.params;
  const order = await Order.find({ email: userEmail, status: { $in: [0, 2, 3] } }).populate(
    "plants._id",
  );
  if (order) {
    return res.status(200).json(order);
  }
  return res.status(404).json("Cart empty");  
};


exports.getCurrentOrderById = async (req, res) => {
  try {
    const order = await Order.findById(req.params._id).populate(
      "plants._id",
    );
    if (!order) {
      return res.status(404).json({ error: "History cart empty" });
    }
    res.status(200).json(order);
  } catch (error) {
    res.status(500).json({ error: "Internal Server Error" });
  }
};
