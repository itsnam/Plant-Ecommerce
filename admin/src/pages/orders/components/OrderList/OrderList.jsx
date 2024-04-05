import React, { useEffect, useState} from "react";
import { getOrders } from "../../api/getOrders.js";
import Moment from "react-moment";
import { StatusFormatter } from "./StatusFormatter.jsx";
import { DropDownMenu } from "./DropDownMenu.jsx";
import { StatusListbox } from "./StatusListbox.jsx";

export const OrderList = () => {
  const [list, setList] = useState([]);

  useEffect(() => {
    getOrders().then((res) => {
      setList(res.data);
    });
  }, [1]);


  return (
    <div className={"rounded-md"}>
      <table
        className={"w-full divide-y divide-gray-200 rounded-md"}
      >
        <thead className={" bg-gray-50"}>
        <tr>
          <th className={"table-label"}>order id</th>
          <th className={"table-label"}>email</th>
          <th className={"table-label"}>amount</th>
          <th className={"table-label"}>payment method</th>
          <th className={"table-label"}>status</th>
          <th className={"table-label"}>date</th>
          <th className={"table-label"}></th>
        </tr>
        </thead>
        <tbody className={"divide-y divide-gray-200 bg-white"}>
        {list.map((item, index) => (
          <tr key={index} className={"hover:bg-gray-100"}>
            <td className={"table-r"}>{item._id}</td>
            <td className={"table-r"}>{item.email}</td>
            <td className={"table-r"}>{item.total}</td>
            <td className={"table-r"}>{item.paymentMethod}</td>
            <td className={"table-r"}><StatusListbox data={item} /></td>
            <td className={"table-r"}>
              <Moment format="DD/MM/YYYY, hh:mm A">
                {item.createdAt}
              </Moment>
            </td>
            <td className={"table-r"}>
              <DropDownMenu data={item} />
            </td>
          </tr>
        ))}
        </tbody>
      </table>
    </div>
  );
};