import React, { createContext, useContext, useEffect, useState } from "react";
import { Link, matchPath, useLocation } from "react-router-dom";
import {
  Bars3Icon,
  Squares2X2Icon,
  UserGroupIcon,
  XMarkIcon,
  HomeIcon,
  ClipboardDocumentListIcon
} from "@heroicons/react/24/outline/index.js";
import {
  UserGroupIcon as UserGroupIconSolid,
  HomeIcon as HomeIconSolid,
  Squares2X2Icon as Squares2X2IconSolid,
  ClipboardDocumentListIcon as ClipboardDocumentListIconSolid
} from "@heroicons/react/24/solid/index.js";

const Sidebar = () => {
  const [expanded, setExpanded] = useState(false);
  const [isActive, setActive] = useState(1);
  const location = useLocation();

  useEffect(() => {
    if (matchPath({ path: "/products/*" }, location.pathname)) {
      setActive(2);
    } else if (matchPath({ path: "/orders/*" }, location.pathname)) {
      setActive(4);
    }else if (matchPath({ path: "/*" }, location.pathname)) {
      setActive(2);
    }
  }, [location]);

  const handleSetActive = (i) => {
    setActive(i);
  };

  return (
    <aside className="min-h-screen">
      <nav className="flex h-full w-fit flex-1 flex-col border-r bg-white shadow-sm">
        <div className="flex items-center justify-between p-4">
          <div
            className={`overflow-hidden transition-all ${expanded ? "w-32" : "w-0"}`}
          >
            <Link to="/" className={"text-xl font-bold"}>
              Dashboard
            </Link>
          </div>
          <button
            onClick={() => setExpanded((curr) => !curr)}
            className={"rounded-md bg-gray-50 p-3 hover:bg-gray-100"}
          >
            {expanded ? (
              <XMarkIcon className={"h-6 w-6"} />
            ) : (
              <Bars3Icon className={"h-6 w-6"} />
            )}
          </button>
        </div>
        <SidebarContext.Provider value={expanded}>
          <ul className={"flex-1 px-4"}>
            <SidebarItems
              id={2}
              active={isActive}
              setActive={handleSetActive}
              link={"/products"}
              text={"Products"}
              iconActive={<Squares2X2IconSolid className={"h-6 w-6"} />}
              icon={<Squares2X2Icon className={"h-6 w-6"} />}
            />
            <SidebarItems
              id={4}
              active={isActive}
              setActive={handleSetActive}
              link={"/orders"}
              text={"Orders"}
              iconActive={<ClipboardDocumentListIconSolid className={"h-6 w-6"} />}
              icon={<ClipboardDocumentListIcon className={"h-6 w-6"} />}
            />
          </ul>
        </SidebarContext.Provider>
      </nav>
    </aside>
  );
};

const SidebarItems = ({
  id,
  icon,
  iconActive,
  text,
  active,
  link,
  setActive,
}) => {
  const expanded = useContext(SidebarContext);
  return (
    <Link to={link}>
      <li
        onClick={(e) => setActive(id)}
        key={id}
        className={`group relative my-1 flex cursor-pointer items-center rounded-md p-3 font-medium transition-colors duration-100
        ${active === id ? "bg-primary text-white" : "text-black hover:bg-indigo-50"}`}
      >
        {active === id ? iconActive : icon}
        <span
          className={`overflow-hidden transition-all ${expanded ? "ml-4 w-48 " : "w-0"}`}
        >
          {text}
        </span>
        {!expanded && (
          <div
            className={`invisible absolute left-full ml-6 -translate-x-3 rounded-md bg-indigo-50 px-4 py-1 text-sm text-indigo-800 opacity-0 transition-all group-hover:visible group-hover:-translate-x-0 group-hover:opacity-100 `}
          >
            {text}
          </div>
        )}
      </li>
    </Link>
  );
};

const SidebarContext = createContext();
export default Sidebar;
