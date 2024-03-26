import { CheckCircleIcon, ClockIcon, XCircleIcon } from "@heroicons/react/24/outline/index.js";

export const StatusFormatter = ({ statusValue }) => {
  const list = [
    {
      text: "Cancelled",
      style : "border-red-400 bg-red-100 text-red-600",
      icon: <XCircleIcon className={"w-4 h-4"}/>
    },
    {
      text: ""
    },
    {
      text: "Pending",
      style : "border-yellow-400 bg-yellow-100 text-yellow-600",
      icon: <ClockIcon className={"w-4 h-4"}/>
    },
    {
      text: "Confirmed",
      style : "border-green-400 bg-green-100 text-green-600",
      icon: <CheckCircleIcon className={"w-4 h-4"}/>
    },
  ];

  return (
    <div className={'border w-fit font-semibold px-2 py-1 rounded text-xs flex gap-1 ' + list[statusValue].style}>
      {list[statusValue].text} {list[statusValue].icon}
    </div>
  );
};