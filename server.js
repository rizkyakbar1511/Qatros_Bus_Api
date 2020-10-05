const express = require("express");
const app = express();
const cors = require("cors");
const router = require("./routes");
const morgan = require("morgan");
const bodyParser = require("body-parser");
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use("/uploads", express.static("uploads"));
app.use(morgan("dev"));

app.use("/api/v1", router);
app.listen(PORT, () => console.log(`server run at port ${PORT}`));
