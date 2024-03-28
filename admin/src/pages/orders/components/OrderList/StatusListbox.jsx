import { useState, Fragment } from "react";
import { Listbox, Transition } from "@headlessui/react";
import { CheckIcon, ChevronUpDownIcon } from "@heroicons/react/16/solid/index.js";
import { StatusFormatter } from "./StatusFormatter.jsx";
import { updateOrder } from "../../api/updateOrder.js";

const status = [
  {
    name: "Cancelled",
    value: 0
  },
  {
    name: "Pending",
    value: 2
  },
  {
    name: "Confirm",
    value: 3
  }
];

export const StatusListbox = ({ data }) => {
  const [selected, setSelected] = useState(data.status);

  const handleSelected = (event) => {
    setSelected(event)
    updateOrder({
      _id : data._id,
      status: event
    })
  }

  return (
    <div className="w-44">
      <Listbox className={"relative mt-1"} value={selected} onChange={handleSelected}>
        <div>
          <Listbox.Button className="relative w-full rounded-md hover:bg-white py-2 pl-3 pr-7 text-left hover:ring-1 ring-gray-300">
            <span className="block truncate"><StatusFormatter statusValue={selected}></StatusFormatter></span>
            <div className="pointer-events-none absolute inset-y-0 right-0 flex items-center pr-2">
              <ChevronUpDownIcon
                className="h-5 w-5 text-gray-400"
                aria-hidden="true"
              />
            </div>
          </Listbox.Button>
          <Transition
            as={Fragment}
            leave="transition ease-in duration-100"
            leaveFrom="opacity-100"
            leaveTo="opacity-0"
          >
            <Listbox.Options className="absolute z-10 mt-1 max-h-60 w-full overflow-auto rounded-md bg-white py-1 shadow-lg ring-1 ring-black/5">
              {status.map((s, index) => (
                <Listbox.Option
                  key={index}
                  className={({ active }) =>
                    `relative select-none py-2 pl-10 pr-4 ${
                      active ? 'bg-gray-100' : ''
                    }`
                  }
                  value={s.value}>
                  {({ selected }) => (
                    <>
                      <span
                        className={`block truncate ${
                          selected ? 'font-medium' : 'font-normal'
                        }`}
                      >
                        {s.name}
                      </span>
                      {selected ? (
                        <span className="absolute inset-y-0 left-0 right-0 flex items-center pl-3">
                          <CheckIcon className="h-5 w-5" aria-hidden="true" />
                        </span>
                      ) : null}
                    </>
                  )}
                </Listbox.Option>
              ))}
            </Listbox.Options>
          </Transition>
        </div>
      </Listbox>
    </div>
  )
};