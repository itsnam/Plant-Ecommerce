const express = require("express");
const fs = require("fs");
const multer = require("multer");
const path = require("path");
const Plant = require("../../models/plant");
const ort = require("onnxruntime-node");
const Jimp = require("jimp");
const predictPlant = require("./predict");

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

const getAllPlants = async (req, res) => {
  try {
    const plants = await Plant.find();
    res.json(plants);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

const getPlantById = async (req, res) => {
  try {
    const plant = await Plant.findById(req.params._id);
    if (!plant) {
      return res.status(404).json({ error: "Plant not found" });
    }
    res.json(plant);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

const predict = async (req, res) => {
  try {
    const result = await predictPlant(
      req.files["image"][0].buffer,
      [1, 3, 299, 299],
    );
    return res.status(200).json(result);
  } catch (e) {
    console.log(e);
  }
};

module.exports = { predict, getAllPlants, createPlant, getPlantById };
