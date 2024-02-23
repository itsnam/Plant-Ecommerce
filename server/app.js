const express = require("express");
const path = require("path");
const cookieParser = require("cookie-parser");
const bodyParser = require("body-parser");
const session = require("express-session");
const cors = require("cors");
const connect = require("./config/connect");

const app = express();
const port = 3000;

app.use("/plants", express.static(path.join(__dirname, "public", "plants")));
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
const favoriteRouter = require("./routes/favorites");
const orderRouter = require("./routes/orders");

app.use("/api/auth", authRouter);
app.use("/api/plants", plantRouter);
app.use("/api/favorites", favoriteRouter);
app.use("/api/orders", orderRouter);

// Thêm cây
/*
const Plant = require("./models/plant")
const newPlant = new Plant({
  name: "Lan hồ điệp chậu nhỏ",
  image: 'public\\plants\\0_1708191794519.jpg',
  description: "Đây là cây Lan hồ điệp chậu nhỏ",
  type: "lan_ho_diep",
  status: 1,
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
