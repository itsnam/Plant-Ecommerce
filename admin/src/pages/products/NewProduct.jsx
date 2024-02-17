import React, { useRef, useState } from "react";
import "react-image-crop/dist/ReactCrop.css";
import Cropper from "react-easy-crop";
import { ArrowUpTrayIcon } from "@heroicons/react/24/outline/index.js";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import getCroppedImage from "./ImageUpload.jsx";
import "./style.css";
import FormValidate from "./FormValidate.jsx";
import plantType from "./PlantType.js";

const NewProduct = ({ title, defaultValue }) => {
  const [formState, setFormState] = React.useState(
    defaultValue || {
      name: "",
      type: "0",
      description: "",
      quantity: "0",
      price: "0",
      image: "",
      status: "1",
    },
  );
  const [crop, setCrop] = React.useState({ x: 0, y: 0 });
  const [zoom, setZoom] = useState(1);
  const [completedCrop, setCompletedCrop] = React.useState();
  const inputFileRef = useRef();
  const navigate = useNavigate();

  const [errors, setErrors] = React.useState(null);

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
    if (!FormValidate(formState)) {
      setErrors("Missing Fields");
      return;
    }
    const formData = new FormData();
    formData.append("name", formState.name);
    formData.append("type", formState.type);
    formData.append("status", parseInt(formState.status));
    formData.append("description", formState.description);
    formData.append("price", parseInt(formState.price));
    formData.append("quantity", parseInt(formState.quantity));
    if (formState.image) {
      const img = await getCroppedImage(formState.image, completedCrop);
      formData.append("image", img, "0");
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
          <div className={"flex gap-5"}>
            <div className={"mt-6 w-1/2"}>
              <label htmlFor="name" className="label">
                Name
              </label>
              <input
                id={"name"}
                type={"text"}
                name={"name"}
                onChange={handleChange}
                value={formState.name}
                className={"input"}
              />
            </div>
            <div className={"mt-6 w-1/3"}>
              <label htmlFor="type" className="label">
                Type
              </label>
              <select
                id={"type"}
                defaultValue={formState.type}
                name={"type"}
                onChange={handleChange}
                className={"input py-2.5 text-sm"}
              >
                {plantType.map((item) => (
                  <option value={item[0]}>{item[1]}</option>
                ))}
              </select>
            </div>
            <div className={"mt-6 w-1/3"}>
              <label htmlFor="type" className="label">
                Status
              </label>
              <select
                id={"type"}
                defaultValue={formState.status}
                name={"type"}
                onChange={handleChange}
                className={"input py-2.5 text-sm"}
              >
                <option value="1">Available</option>
                <option value="0">Unavailable</option>
              </select>
            </div>
          </div>
          <div className={"flex gap-5"}>
            <div className={"mt-6 w-1/2"}>
              <label htmlFor="quantity" className="label">
                Quantity
              </label>
              <input
                id={"quantity"}
                type={"number"}
                name={"quantity"}
                onChange={handleChange}
                value={formState.quantity}
                className={"input"}
              />
            </div>
            <div className={"mt-6 w-1/2"}>
              <label htmlFor="price" className="label">
                Price (VND)
              </label>
              <input
                id={"price"}
                type={"number"}
                name={"price"}
                onChange={handleChange}
                value={formState.price}
                className={"input"}
              />
            </div>
          </div>
          <div className={"mt-6"}>
            <label htmlFor="description" className="label">
              Description (optional)
            </label>
            <textarea
              id="description"
              rows="7"
              className="input"
              name="description"
              onChange={handleChange}
              value={formState.description}
            />
          </div>
        </div>
        <div className={"mt-6 w-1/2"}>
          <label htmlFor="image" className="label">
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
                    "flex h-full w-full items-center justify-center text-custom_gray-600"
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
      </div>
      {errors && <div className={"font-semibold text-red-600"}>{errors}</div>}
      <div
        onClick={handleSubmit}
        className={
          "mt-6 w-fit cursor-pointer rounded-md bg-primary px-6 py-3 font-medium text-white hover:bg-blue-700"
        }
      >
        Add Product
      </div>
    </div>
  );
};

export default NewProduct;
