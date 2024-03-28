import { Menu, Transition } from "@headlessui/react";
import { EllipsisHorizontalIcon } from "@heroicons/react/24/outline/index.js";
import React, { Fragment, useState } from "react";
import { OrderStatusModal } from "../modals/OrderStatusModal.jsx";

export const DropDownMenu = ({data}) => {
  const [isModalOpen, setIsModelOpen] = useState(false);

  return (
    <>
      <OrderStatusModal data={data} isOpen={isModalOpen} setIsOpen={setIsModelOpen}/>
      <Menu as="div" className={"relative inline-block text-left"}>
        <Menu.Button className={"table-trailing "}>
          <EllipsisHorizontalIcon className={"h-5 w-5"} />
        </Menu.Button>
        <Transition
          as={Fragment}
          enter="transition ease-out duration-100"
          enterFrom="transform opacity-0 scale-95"
          enterTo="transform opacity-100 scale-100"
          leave="transition ease-in duration-75"
          leaveFrom="transform opacity-100 scale-100"
          leaveTo="transform opacity-0 scale-95"
        >
          <Menu.Items className=" p-1 z-10 absolute right-0 mt-1 w-56 origin-top-right rounded-md bg-white shadow-lg ring-1 ring-black/5">
            <Menu.Item>
              {({ active }) => (
                <button
                  className={`${
                    active ? 'bg-gray-100 text-black' : 'text-gray-700'} 
                    group flex w-full items-center rounded-md px-2 py-2 text-sm font-semibold`}>
                  View order details
                </button>
              )}
            </Menu.Item>
          </Menu.Items>
        </Transition>
      </Menu>
    </>
  )
}