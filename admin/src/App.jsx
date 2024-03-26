import { BrowserRouter, Route, Routes } from "react-router-dom";
import NotFound from "./components/NotFound.jsx";
import Layout from "./pages/products/Layout.jsx";
import Sidebar from "./components/Sidebar.jsx";
import DashboardPage from "./pages/DashboardPage.jsx";
import React from "react";
import UserPage from "./pages/UserPage.jsx";
import { Orders } from "./pages/orders/index.jsx";


function App() {
  return (
    <BrowserRouter>
      <div className={"flex h-full overflow-y-auto bg-custom_gray-100"}>
        <Sidebar />
        <Routes>
          <Route path="/" exact element={<DashboardPage />} />
          <Route path="/products/*" element={<Layout />} />
          <Route path="/users" element={<UserPage />} />
          <Route path="/orders" element={<Orders/>}/>
          <Route path="*" element={<NotFound />} />
        </Routes>
      </div>
    </BrowserRouter>
  );
}

export default App;
