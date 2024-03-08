import { useEffect, useState } from "react";
import axios from "axios";
import { PencilSquareIcon } from "@heroicons/react/24/outline/index.js";
import { EditModal } from "./EditModal.jsx";

const Products = () => {
  const [showEditModal, setShowEditModal] = useState(false);
  const [editRow, setEditRow] = useState(null);
  const [list, setList] = useState([]);

  useEffect(() => {
    axios({
      method: "get",
      url: "http://localhost:3000/api/plants",
    }).then((res) => {
      if (res.status === 200) {
        res.data.map((item) => {
          item.image = "http://localhost:3000/" + item.image;
        });
        setList(res.data);
      }
    });
  }, [1]);

  const handleSubmit = (data) => {
    setList(
      list.map((currRow, idx) => {
        if (idx !== editRow) return currRow;
        data.image = "http://localhost:3000/" + data.image;
        return data;
      }),
    );
    setEditRow(null);
    setShowEditModal(false);
  };

  return (
    <div className={"rounded-md"}>
      <EditModal
        onSubmit={handleSubmit}
        product={list[editRow]}
        isOpen={showEditModal}
        onClose={() => setShowEditModal(false)}
      />
      <table
        className={"w-full divide-y divide-gray-200 overflow-hidden rounded-md"}
      >
        <thead className={" bg-gray-50"}>
          <tr>
            <th className={"table-label"}>product</th>
            <th className={"table-label"}>type</th>
            <th className={"table-label"}>status</th>
            <th className={"table-label"}>price</th>
            <th className={"table-label"}>quantity</th>
            <th className={"table-label"}></th>
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
              <td className={"whitespace-nowrap px-6 py-4"}>
                <button
                  onClick={() => {
                    setEditRow(index);
                    setShowEditModal(true);
                  }}
                  className={"rounded-md p-2 hover:bg-custom_gray-100"}
                >
                  <PencilSquareIcon className={"h-5 w-5"} />
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};
export default Products;
