import { useEffect, useState } from "react";
import axios from "axios";

const Products = () => {
  const [list, setList] = useState([]);

  useEffect(() => {
    axios({
      method: "get",
      url: "http://localhost:3000/api/plants",
      withCredentials: true,
    }).then((res) => {
      if (res.status === 200) {
        setList(res.data);
        console.log(res.data);
      }
    });
  }, [1]);
  return (
    <div className={"rounded-md"}>
      <table
        className={
          "w-full divide-y divide-gray-200 overflow-hidden rounded-md p-10"
        }
      >
        <thead className={" bg-gray-50"}>
          <tr>
            <th className={"table-label"}>product</th>
            <th className={"table-label"}>type</th>
            <th className={"table-label"}>status</th>
            <th className={"table-label"}>price</th>
            <th className={"table-label"}>quantity</th>
          </tr>
        </thead>
        <tbody className={"divide-y divide-gray-200 bg-white"}>
          {list.map((item, index) => (
            <tr key={index}>
              <td className={"whitespace-nowrap px-6 py-4"}>{item.name}</td>
              <td className={"whitespace-nowrap px-6 py-4"}>{item.type}</td>
              <td className={"whitespace-nowrap px-6 py-4"}>{item.status}</td>
              <td className={"whitespace-nowrap px-6 py-4"}>{item.price}</td>
              <td className={"whitespace-nowrap px-6 py-4"}>{item.quantity}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};
export default Products;
