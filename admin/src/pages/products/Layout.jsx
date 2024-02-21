import React, { useEffect, useState } from "react";
import NewProduct from "./NewProduct.jsx";
import { Link, matchPath, Route, Routes, useLocation } from "react-router-dom";
import Products from "./Products.jsx";
import { FunnelIcon } from "@heroicons/react/24/outline/index.js";
import { Listbox } from "@headlessui/react";

const filters = ["none", "active", "inactive", "out of stock"];

const Layout = () => {
  const [active, setActive] = useState(1);
  const [filter, setFilter] = useState(filters[0]);
  const location = useLocation();

  useEffect(() => {
    if (matchPath({ path: "/products/add-product" }, location.pathname)) {
      setActive(2);
    } else if (matchPath({ path: "/products/*" }, location.pathname)) {
      setActive(1);
    }
  }, [location]);

  const handleClicked = (id) => {
    setActive(id);
  };

  return (
    <div className={"flex w-full flex-col px-7 py-10"}>
      <h1 className={"mb-7 text-3xl font-bold"}>Products</h1>
      <div className={"mb-7 flex justify-between"}>
        <div className={"flex"}>
          <Link to={"/products"}>
            <button
              onClick={() => handleClicked(1)}
              className={`rounded-md border px-4 py-3 font-medium ${active === 1 ? "border-primary bg-primary text-white" : "bg-white text-black"}`}
            >
              Product List
            </button>
          </Link>
          {active === 1 ? (
            <Listbox value={filter} onChange={setFilter}>
              <Listbox.Button>{filter}</Listbox.Button>
              <Listbox.Options>
                {filters.map((item) => (
                  <Listbox.Option value={item}>{item}</Listbox.Option>
                ))}
              </Listbox.Options>
            </Listbox>
          ) : null}
        </div>
        <Link to={"/products/add-product"}>
          <button
            onClick={() => handleClicked(2)}
            className={`rounded-md border px-4 py-3 font-medium ${active === 2 ? "border-primary bg-primary text-white" : "bg-white text-black"}`}
          >
            New Product
          </button>
        </Link>
      </div>
      <div className={"h-fit w-full rounded-md border bg-white"}>
        <Routes>
          <Route
            path="/add-product"
            element={<NewProduct p={"p-10"} title={"Add New Product"} />}
          />
          <Route path={"/"} element={<Products />} />
        </Routes>
      </div>
    </div>
  );
};
export default Layout;
