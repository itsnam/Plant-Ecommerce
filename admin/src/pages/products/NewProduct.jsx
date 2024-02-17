import React, { useRef, useState } from "react";
import "react-image-crop/dist/ReactCrop.css";
import Cropper from "react-easy-crop";
import { ArrowUpTrayIcon } from "@heroicons/react/24/outline/index.js";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import getCroppedImage from "./ImageUpload.jsx";
import "./style.css";
import plantType from "./PlantType.js";

const NewProduct = ({ title, defaultValue }) => {
  const [formState, setFormState] = React.useState(
    defaultValue || {
      name: "",
      category: "0",
      image: "",
      description: "",
      quantity: "",
      price: "",
    },
  );
  const [crop, setCrop] = React.useState({ x: 0, y: 0 });
  const [zoom, setZoom] = useState(1);
  const [completedCrop, setCompletedCrop] = React.useState();
  const [croppedImage, setCroppedImage] = React.useState();
  const inputFileRef = useRef();

  const [errors, setErrors] = React.useState(null);
  const navigate = useNavigate();

  const handleChange = (e) => {
    setErrors();
    setFormState({ ...formState, [e.target.name]: e.target.value });
  };

  const handleImageChange = (e) => {
    setErrors();
    if (e.target.files && e.target.files.length > 0) {
      const reader = new FileReader();
      reader.addEventListener("load", () =>
        setFormState({
          ...formState,
          image: reader.result?.toString() || "",
        }),
      );
      reader.readAsDataURL(e.target.files[0]);
    }
  };

  const handleCropCompleted = (croppedArea, croppedAreaPixels) => {
    setCompletedCrop(croppedAreaPixels);
  };

  const handleSubmit = async () => {
    const formData = new FormData();
    formData.append("name", formState.name);
    formData.append("type", formState.type);
    formData.append("status", parseInt(formState.status));
    formData.append("description", formState.description);
    formData.append("price", parseInt(formState.price));
    formData.append("quantity", parseInt(formState.quantity));
    if (formState.image) {
      const img = await getCroppedImage(formState.image, completedCrop);
      console.log(img);
      formData.append("img", img, "0");
    }
    axios({
      method: "post",
      url: "http://localhost:3000/api/plants",
      headers: {
        "Content-Type": "multipart/form-data",
      },
      withCredentials: true,
      data: formData,
    }).then((res) => {
      navigate("/products/");
    });
  };

  return (
    <div className={"flex flex-col p-10"}>
      <div className={"text-lg font-bold"}>{title}</div>
      <div className={"mt-3 flex w-full gap-5"}>
        <div className={"flex w-1/2 flex-col"}>
          <div className={"w-1/2 text-lg font-semibold"}>{title}</div>
          <div className={"flex gap-5"}>
            <div className={"mt-6 w-1/2"}>
              <label
                htmlFor="name"
                className="block text-sm font-medium leading-6 text-custom_gray-600"
              >
                Name
              </label>
              <input
                id={"name"}
                type={"text"}
                name={"name"}
                onChange={handleChange}
                value={formState.name}
                className={
                  "mt-1 w-full rounded-md border-0 px-3 py-2 text-sm leading-6 text-gray-900 ring-1 ring-inset ring-gray-300 focus:outline-none focus:ring-2"
                }
              />
            </div>
            <div className={"mt-6 w-1/2"}>
              <label
                htmlFor="category"
                className="block text-sm font-medium leading-6 text-custom_gray-600"
              >
                Category
              </label>
              <select
                id={"category"}
                defaultValue={formState.category}
                name={"category"}
                onChange={handleChange}
                className={
                  "mt-1 w-full rounded-md border-0 px-3 py-2.5 text-sm leading-6 text-gray-900 ring-1 ring-inset ring-gray-300 focus:outline-none focus:ring-2"
                }
              >
                {plantType.map((item) => (
                  <option value={item[0]}>{item[1]}</option>
                ))}
              </select>
            </div>
          </div>
          <div className={"flex gap-5"}>
            <div className={"mt-6 w-1/2"}>
              <label
                htmlFor="quantity"
                className="block text-sm font-medium leading-6 text-custom_gray-600"
              >
                Quantity
              </label>
              <input
                id={"quantity"}
                type={"number"}
                name={"quantity"}
                onChange={handleChange}
                value={formState.quantity}
                className={
                  "mt-1 w-full rounded-md border-0 px-3 py-2 text-sm leading-6 text-gray-900 ring-1 ring-inset ring-gray-300 focus:outline-none focus:ring-2"
                }
              />
            </div>
            <div className={"mt-6 w-1/2"}>
              <label
                htmlFor="price"
                className="block text-sm font-medium leading-6 text-custom_gray-600"
              >
                Price
              </label>
              <input
                id={"price"}
                type={"number"}
                name={"price"}
                onChange={handleChange}
                value={formState.price}
                className={
                  "mt-1 w-full rounded-md border-0 px-3 py-2 text-sm leading-6 text-gray-900 ring-1 ring-inset ring-gray-300 focus:outline-none focus:ring-2"
                }
              />
            </div>
          </div>
          <div className={"mt-6"}>
            <label
              htmlFor="description"
              className="block text-sm font-medium leading-6 text-custom_gray-600"
            >
              Description
            </label>
            <textarea
              id="description"
              rows="6"
              className="mt-1 block w-full rounded-md border-0 px-3 py-2 text-sm leading-6 text-gray-900 ring-1 ring-inset ring-gray-300 focus:outline-none focus:ring-2"
              name="description"
              onChange={handleChange}
              value={formState.description}
            />
          </div>
          <div className={"mt-6 "}>
            <label
              htmlFor="image"
              className="block text-sm font-medium leading-6 text-custom_gray-600"
            >
              Image
            </label>

            <input
              ref={inputFileRef}
              id="image"
              name="image"
              className="hidden"
              accept="image/*"
              type="file"
              onChange={handleImageChange}
            />
            <div className={"mt-1 flex border border-gray-300"}>
              <div className={"relative h-96 w-full"}>
                {formState.image ? (
                  <Cropper
                    aspect={1}
                    objectFit={"contain"}
                    image={formState.image}
                    onCropChange={setCrop}
                    onCropComplete={handleCropCompleted}
                    crop={crop}
                    zoom={zoom}
                  />
                ) : (
                  <div
                    className={
                      "flex h-full w-full items-center justify-center text-custom_gray-600 "
                    }
                  >
                    <div
                      onClick={() => inputFileRef.current.click()}
                      className={
                        " rounded-md border p-5 hover:bg-custom_gray-100 hover:text-black"
                      }
                    >
                      <ArrowUpTrayIcon className={"h-10 w-10 "} />
                    </div>
                  </div>
                )}
              </div>
            </div>
            <div
              className={
                "m-auto flex h-fit items-center justify-center gap-3 border bg-custom_gray-100 px-4 py-2"
              }
            >
              <button
                className={"whitespace-nowrap rounded-md border p-2"}
                onClick={() => inputFileRef.current.click()}
              >
                <span>Select Image</span>
              </button>
              {formState.image && (
                <input
                  className={
                    "h-1 w-1/2 cursor-pointer appearance-none bg-gray-300 [&::-webkit-slider-thumb]:h-4 [&::-webkit-slider-thumb]:w-4 [&::-webkit-slider-thumb]:appearance-none [&::-webkit-slider-thumb]:rounded-full [&::-webkit-slider-thumb]:bg-custom_gray-600"
                  }
                  type="range"
                  value={zoom}
                  min={1}
                  max={3}
                  step={0.1}
                  aria-labelledby="Zoom"
                  onChange={(e) => {
                    setZoom(e.target.value);
                  }}
                />
              )}
            </div>
          </div>
          <div
            onClick={handleSubmit}
            className={
              "mt-6 w-fit cursor-pointer rounded-md bg-primary px-5 py-2 font-medium text-white hover:bg-blue-700"
            }
          >
            Submit
          </div>
        </div>
      </div>
    </div>
  );
};

export default NewProduct;
