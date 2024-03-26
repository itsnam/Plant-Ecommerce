import { useEffect, useState } from "react";
import { getOrders } from "../api/getOrders.js";

export const OrderList = () => {
  const [list, setList] = useState([]);

  useEffect(() => {
    getOrders().then(r => setList(r.data))
  })

}