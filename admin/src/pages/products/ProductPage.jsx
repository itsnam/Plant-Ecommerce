import React, { useEffect, useState } from "react";
import NewProduct from "./NewProduct.jsx";
import { Link, matchPath, Route, Routes, useLocation } from "react-router-dom";

const ProductPage = () => {
  const [active, setActive] = useState(1);
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
      <div className={"mb-7 flex"}>
        <Link to={"/products"}>
          <button
            onClick={() => handleClicked(1)}
            className={`rounded-l-md border px-4 py-3 font-medium ${active === 1 ? "border-primary bg-primary text-white" : "bg-white text-black"}`}
          >
            Product List
          </button>
        </Link>
        <Link to={"/products/add-product"}>
          <button
            onClick={() => handleClicked(2)}
            className={`rounded-r-md border border-y border-r px-4 py-3 font-medium ${active === 2 ? "border-primary bg-primary text-white" : "bg-white text-black"}`}
          >
            New Product
          </button>
        </Link>
      </div>
      <div className={"h-full w-full rounded-md border bg-white p-10"}>
        <Routes>
          <Route
            path="/add-product"
            element={<NewProduct title={"Add New Product"} />}
          />
        </Routes>
      </div>
    </div>
  );
};
export default ProductPage;
