import { useState } from "react";
import { Dialog } from "@headlessui/react";
import NewProduct from "./NewProduct.jsx";

export const EditModal = ({ isOpen, onClose, product, onSubmit }) => {
  return (
    <Dialog open={isOpen} onClose={onClose}>
      <div className="fixed inset-0 bg-black/30" aria-hidden="true" />
      <div className="fixed inset-0 flex w-screen items-center justify-center">
        <Dialog.Panel className={"mx-auto w-2/3 rounded-md bg-white p-6"}>
          <NewProduct
            onSubmit={onSubmit}
            isEdit={true}
            title={"Edit product"}
            defaultValue={product}
          />
        </Dialog.Panel>
      </div>
    </Dialog>
  );
};
