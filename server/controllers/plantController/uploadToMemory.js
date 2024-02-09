const multer = require("multer");

const storage = multer.memoryStorage();
let uploadToMemory = multer({
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

module.exports = uploadToMemory;
