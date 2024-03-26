import axios from "axios";
import { API_URL } from "../../../config/index.js";

export const updateOrder = (data) => {
  return axios.put(API_URL + '/orders', data);
}