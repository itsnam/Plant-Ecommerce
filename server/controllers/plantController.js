const express = require("express");
const fs = require("fs");
const multer = require("multer");
const path = require("path");
const Plant = require("../models/plant");

let storage = multer.diskStorage({
  destination(req, file, cb) {
    const path = "./public/plant/";
    if (!fs.existsSync(path)) {
      fs.mkdirSync(path, { recursive: true });
    }
    cb(null, path);
  },
  filename(req, file, cb) {
    cb(null, path.parse(file.originalname).name + "_" + Date.now() + ".jpg");
  },
});

let upload = multer({
  storage: storage,
  fileFilter: function (req, file, cb) {
    const authorizedMimeTypes = ["image/png", "image/jpeg", "image/jpg"];
    if (
      file.mimetype === "image/jpeg" ||
      file.mimetype === "image/png" ||
      file.mimetype === "image/jpg"
    ) {
      cb(null, true);
    } else {
      cb(null, false);
    }
  },
}).fields([{ name: "img", maxCount: 1 }]);

let createPlant = async (req, res) => {
  try {
    let file = req.files;
    if (!file) {
      return res.json({ msg: "Invalid file" });
    }
    console.log(file["img"][0]);
    const app = await Plant.create({
      name: req.body.name,
      type: req.body.type,
      image: file["img"][0].path,
      description: req.body.description,
      quantity: req.body.quantity,
      price: req.body.price,
    });
    return res.status(200).json("Plant created successfully");
  } catch (error) {
    console.log(error);
    res.status(500).send("Server error");
  }
};

module.exports = { upload, createPlant };
