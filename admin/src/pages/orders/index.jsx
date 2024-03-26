import React, { useEffect, useState } from "react";
import { Link, matchPath, Route, Routes, useLocation } from "react-router-dom";
import { FunnelIcon } from "@heroicons/react/24/outline/index.js";
import { Listbox } from "@headlessui/react";
import Products from "../products/Products.jsx";
import { OrderList } from "./components/OrderList.jsx";

const filters = ["none", "active", "inactive", "out of stock"];

export const Orders = () => {
  const [active, setActive] = useState(1);
  const [filter, setFilter] = useState(filters[0]);
  const location = useLocation();

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
