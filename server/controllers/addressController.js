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
    if (!addressList | addressList.addresses.length === 0) {
      return res.status(200).json([]);
    }
    return res.status(200).json(addressList);
  } catch (e) {}
};

exports.addNewAddress = async (req, res) => {
  try {
    const { email, name, phone, street, ward, district, province } = req.body;
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

exports.deleteAddress = async (req, res) => {
  try {
    const { email, addressId } = req.params;
    let addressList = await Address.findOne({ email: email });
    if (!addressList) {
      return res.status(404).json({ message: "Address list not found" });
    }
    const updatedAddresses = addressList.addresses.filter(address => address._id.toString() !== addressId);
    if (updatedAddresses.length === addressList.addresses.length) {
      return res.status(404).json({ message: "Address not found" });
    }
    addressList.addresses = updatedAddresses;
    await addressList.save();
    return res.status(200).json({ message: "Address deleted successfully" });
  } catch (error) {
    return res.status(500).json({ message: "Internal server error" });
  }
};

exports.updateAddress = async (req, res) => {
  try {
    const { email, addressId } = req.params;
    const { name, phone, street, ward, district, province } = req.body;

    let addressList = await Address.findOne({ email: email });
    if (!addressList) {
      return res.status(404).json({ message: "Address list not found" });
    }
    const addressToUpdate = addressList.addresses.find(address => address._id.toString() === addressId);
    if (!addressToUpdate) {
      return res.status(404).json({ message: "Address not found" });
    }
    
    if (name) addressToUpdate.name = name;
    if (phone) addressToUpdate.phone = phone;
    if (street) addressToUpdate.street = street;
    if (ward) addressToUpdate.ward = ward;
    if (district) addressToUpdate.district = district;
    if (province) addressToUpdate.province = province;
    await addressList.save();
    return res.status(200).json({ message: "Address updated successfully" });
  } catch (error) {
    return res.status(500).json({ message: "Internal server error" });
  }
};
