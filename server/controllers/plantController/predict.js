const express = require("express");
const path = require("path");
const Jimp = require("jimp");
const ort = require("onnxruntime-node");
const pClasses = require("../../data/classes");
const predictPlant = async (file, dims) => {
  try {
    const session = await ort.InferenceSession.create(
      path.resolve(__dirname, "../../public/model.onnx"),
    );

    let imageData = await Jimp.read(file);
    await imageData.resize(dims[2], dims[3]);

    const imageBufferData = imageData.bitmap.data;
    const redArray = [];
    const greenArray = [];
    const blueArray = [];
    for (let i = 0; i < imageBufferData.length; i += 4) {
      redArray.push(imageBufferData[i]);
      greenArray.push(imageBufferData[i + 1]);
      blueArray.push(imageBufferData[i + 2]);
    }
    const transposedData = redArray.concat(greenArray).concat(blueArray);
    let i,
      l = transposedData.length;
    const float32Data = new Float32Array(dims[1] * dims[2] * dims[3]);
    for (i = 0; i < l; i++) {
      float32Data[i] = transposedData[i] / 255.0;
    }
    const inputTensor = new ort.Tensor("float32", float32Data, dims);
    const output = await session.run({ "input.1": inputTensor });
    const outputSoftmax = softmax(output["889"].cpuData);
    return getTopProbabilitiy(outputSoftmax);
  } catch (e) {
    console.log(e);
  }
};
const softmax = (array) => {
  const largestNumber = Math.max(...array);
  const sumOfExp = array
    .map((resultItem) => Math.exp(resultItem - largestNumber))
    .reduce((prevNumber, currentNumber) => prevNumber + currentNumber);
  return array.map((resultValue, index) => {
    return Math.exp(resultValue - largestNumber) / sumOfExp;
  });
};

const getTopProbabilitiy = (array) => {
  const max = Math.max(...array);
  const index = array.indexOf(max);
  return {
    id: pClasses[index][0],
    name: pClasses[index][1],
    probability: max,
  };
};

module.exports = predictPlant;
