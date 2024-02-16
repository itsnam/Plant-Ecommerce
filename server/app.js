const express = require("express");
const path = require("path");
const cookieParser = require("cookie-parser");
const bodyParser = require("body-parser");
const session = require("express-session");
const cors = require("cors");
const connect = require("./config/connect");

const app = express();
const port = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname)));
app.use(
  session({
    secret: "my-key",
    saveUninitialized: true,
  }),
);
app.use(
  cors({
    origin: ["http://localhost:5173"],
    credentials: true,
    optionSuccessStatus: 200,
  }),
);

const authRouter = require("./routes/auth");
const plantRouter = require("./routes/plants");

app.use("/api/auth", authRouter);
app.use("/api/plants", plantRouter);

// Thêm cây
/*
const Plant = require("./models/plant")
const newPlant = new Plant({
  name: "Cây nha đam",
  image: "https://i.pinimg.com/564x/4c/b7/8f/4cb78f96241714fb1d7447bbdacc3162.jpg",
  description: "Đây là cây nha đam",
  type: "Cây trong nhà và ngoài trời",
  status: true,
  quantity: 65,
  price: 65000, 
  sold: 78 
});

newPlant.save()
  .then(savedPlant => {
    console.log("Đã thêm cây vào cơ sở dữ liệu:", savedPlant);
  })
  .catch(error => {
    console.error("Lỗi khi thêm cây vào cơ sở dữ liệu:", error);
  });
*/
app.listen(port, () => {
  console.log(`Server running on: http://localhost:${port}`);
});
