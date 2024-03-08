import React from "react";
import axios from "axios";
const createImage = (url) =>
  new Promise(async (resolve, reject) => {
    const image = new Image();
    image.setAttribute("crossOrigin", "anonymous");
    image.addEventListener("load", () => resolve(image));
    image.addEventListener("error", (error) => {
      console.error("Error loading image:", error);
      reject(error);
    });
    image.src = url;
  });
const getCroppedImage = async (src, pixelCrop) => {
  const image = await createImage(src);
  const canvas = document.createElement("canvas");
  const ctx = canvas.getContext("2d");
  if (!ctx) {
    return null;
  }
  canvas.width = pixelCrop.width;
  canvas.height = pixelCrop.height;

  ctx.drawImage(
    image,
    pixelCrop.x,
    pixelCrop.y,
    pixelCrop.width,
    pixelCrop.height,
    0,
    0,
    pixelCrop.width,
    pixelCrop.height,
  );

  return new Promise((resolve, reject) => {
    canvas.toBlob((file) => {
      resolve(file);
    }, "image/jpeg");
  });
};

export default getCroppedImage;
