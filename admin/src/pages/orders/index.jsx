import 'react'
import { Link, Route, Routes } from "react-router-dom";
import { Listbox } from "@headlessui/react";
import NewProduct from "../products/NewProduct.jsx";
import Products from "../products/Products.jsx";
import React from "react";

export const Orders = () => {
  return(
    <div className={"flex w-full flex-col px-7 py-10"}>
      <h1 className={"mb-7 text-3xl font-bold"}>Orders</h1>
      <div className={"h-fit w-full rounded-md border bg-white"}>
        <Routes>
          <Route path={"/"} element={<Products />} />
        </Routes>
      </div>
    </div>
  )
}
