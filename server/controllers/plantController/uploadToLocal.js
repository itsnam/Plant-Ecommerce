const multer = require("multer");
const fs = require("fs");
const path = require("path");

let storage = multer.diskStorage({
  destination(req, file, cb) {
    const path = "./public/plants/";
    if (!fs.existsSync(path)) {
      fs.mkdirSync(path, { recursive: true });
    }
    cb(null, path);
  },
  filename(req, file, cb) {
    cb(null, path.parse(file.originalname).name + "_" + Date.now() + ".jpg");
  },
});

let uploadToLocal = multer({
  storage: storage,
  fileFilter: function (req, file, cb) {
    if (
      file.mimetype === "image/jpeg" ||
      file.mimetype === "image/png" ||
      file.mimetype === "image/jpg"
    ) {
      cb(null, true);
    } else {
      cb(null, false);
    }
  },
}).fields([{ name: "image", maxCount: 1 }]);

module.exports = uploadToLocal;
