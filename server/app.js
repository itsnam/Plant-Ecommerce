const express = require("express");
const path = require("path");
const cookieParser = require("cookie-parser");
const bodyParser = require("body-parser");
const session = require("express-session");
const cors = require("cors");
const connect = require("./config/connect");

const app = express();
const port = 3000;

app.use(
  cors({
    origin: "http://localhost:5173",
  }),
);
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

const authRouter = require("./routes/auth");
const plantRouter = require("./routes/plants");
const favoriteRouter = require("./routes/favorites");
const orderRouter = require("./routes/orders");
const addressRouter = require("./routes/address");

app.use("/api/auth", authRouter);
app.use("/api/plants", plantRouter);
app.use("/api/favorites", favoriteRouter);
app.use("/api/orders", orderRouter);
app.use("/api/addresses", addressRouter);

app.listen(port, () => {
  console.log(`Server running on: http://localhost:${port}`);
});
