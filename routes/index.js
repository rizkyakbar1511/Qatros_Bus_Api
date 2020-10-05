const express = require("express");
const router = express.Router();
const upload = require("../config/multer.config");
const {
  findAll,
  findById,
  create,
  update,
  remove,
} = require("../controllers/bus");

const { create: createSchedule } = require("../controllers/schedule");
const { create: createStation } = require("../controllers/station");

router.get("/busses", findAll);
router.post("/busses", upload, create);
router.get("/bus/:id", findById);
router.put("/bus/:id", update);
router.delete("/bus/:id", remove);

//station routes
router.post("/station", createStation);

//schedule routes
router.post("/schedule", createSchedule);

//Other routes
router.get("*", (req, res) => {
  res.status(404).send({ error: "404 Not Found" });
});

module.exports = router;
