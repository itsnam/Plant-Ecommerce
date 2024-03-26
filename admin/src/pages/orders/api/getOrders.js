import axios from "axios";
import { API_URL } from "../../../config/index.js";

export const getOrders = async () => {
  return await axios.get(API_URL + '/orders').then(res => res.data)
}
