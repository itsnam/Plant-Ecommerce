const express = require('express');
const path = require('path');
const cookieParser = require('cookie-parser');
const session = require('express-session');
const connect = require('./config/connect')
const app = express();
port = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(session({
  secret: "my-key",
  saveUninitialized: true,
}));

const authRouter = require('./routes/auth');

app.use('/api/auth', authRouter);

app.listen(port, () => {
  console.log(`Server running on: http://localhost:${port}`);
});

