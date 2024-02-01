const express = require("express");
const path = require("path");
const cookieParser = require("cookie-parser");
const bodyParser = require("body-parser");
const session = require("express-session");
const cors = require("cors");
const connect = require("./config/connect");
const app = express();
port = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, "public")));
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
const plantRouter = require("./routes/plant");

app.use("/api/auth", authRouter);
app.use("/api/plants", plantRouter);

app.listen(port, () => {
  console.log(`Server running on: http://localhost:${port}`);
});
