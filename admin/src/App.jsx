import {BrowserRouter, Route, Routes} from "react-router-dom";
import NotFound from "./components/NotFound.jsx";

function App() {
    return (
        <BrowserRouter>
            <Routes>
                <Route/>
                <Route path="*" element={<NotFound/>}/>
            </Routes>
        </BrowserRouter>
    )
}

export default App
