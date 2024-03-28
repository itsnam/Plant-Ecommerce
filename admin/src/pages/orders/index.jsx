import React, {useState } from "react";
import {Route, Routes, useLocation } from "react-router-dom";
import { OrderList } from "./components/OrderList/OrderList.jsx";

const filters = ["none", "active", "inactive", "out of stock"];

export const Orders = () => {
  return (
    <div className={"flex w-full flex-col px-7 py-10"}>
      <h1 className={"mb-7 text-2xl font-bold"}>Orders</h1>
      <div className={"h-fit w-full rounded-md border bg-white"}>
        <Routes>
          <Route path={"/"} element={<OrderList />} />
        </Routes>
      </div>
    </div>
  );
};
