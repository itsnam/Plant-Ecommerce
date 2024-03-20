const Address = require("../models/address");
const { add } = require("nodemon/lib/rules");

const createAddressList = async (email) => {
  return await Address.create({
    email: email,
    addresses: [],
  });
};

exports.getAddress = async (req, res) => {
  try {
    const { email } = req.params;
    let addressList = await Address.findOne({
      email: email,
    });
    return res.status(200).json(addressList);
  } catch (e) {}
};

exports.addNewAddress = async (req, res) => {
  try {
    const { email, name, phone, street, ward, district, province } = req.body;
    console.log(province);
    let addressList = await Address.findOne({
      email: email,
    });
    if (addressList == null) {
      addressList = await createAddressList(email);
    }
    const newAddress = {
      name: name,
      phone: phone,
      street: street,
      ward: ward,
      district: district,
      province: province,
    };
    addressList.addresses.push(newAddress);
    await addressList.save();
    return res.status(200).json("address added");
  } catch (e) {}
};
