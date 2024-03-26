import axios from "axios";
import { API_URL } from "../../../config/index.js";

export const getOrders = () => {
  return axios.get(API_URL + '/orders');
}
