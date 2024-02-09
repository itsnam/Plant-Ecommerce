const express = require("express");
const path = require("path");
const Jimp = require("jimp");
const ort = require("onnxruntime-node");

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

    return output;
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

const imagenetClassesTopK = (classProbabilities, k = 5) => {
  const probs = _.isTypedArray(classProbabilities)
    ? Array.prototype.slice.call(classProbabilities)
    : classProbabilities;

  const sorted = _.reverse(
    _.sortBy(
      probs.map((prob, index) => [prob, index]),
      (probIndex) => probIndex[0],
    ),
  );

  const topK = _.take(sorted, k).map((probIndex) => {
    const iClass = imagenetClasses[probIndex[1]];
    return {
      id: iClass[0],
      index: parseInt(probIndex[1].toString(), 10),
      name: iClass[1].replace(/_/g, " "),
      probability: probIndex[0],
    };
  });
  return topK;
};

module.exports = predictPlant;
