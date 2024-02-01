import { BrowserRouter, Route, Routes } from "react-router-dom";
import NotFound from "./components/NotFound.jsx";
import ProductPage from "./pages/products/ProductPage.jsx";
import Sidebar from "./components/Sidebar.jsx";
import DashboardPage from "./pages/DashboardPage.jsx";
import React from "react";
import UserPage from "./pages/UserPage.jsx";

function App() {
  return (
    <BrowserRouter>
      <div className={"bg-custom_gray-100 flex h-full overflow-y-auto"}>
        <Sidebar />
        <Routes>
          <Route path="/" exact element={<DashboardPage />} />
          <Route path="/products/*" element={<ProductPage />} />
          <Route path="/users" element={<UserPage />} />
          <Route path="*" element={<NotFound />} />
        </Routes>
      </div>
    </BrowserRouter>
  );
}

export default App;
