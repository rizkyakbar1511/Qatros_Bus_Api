const db = require("../config/db.config");

exports.create = async (req, res) => {
  try {
    const { station_name, schedule_id } = req.body;
    const {
      rows,
    } = await db.query(
      "INSERT INTO stations (station_name,schedule_id) VALUES ($1, $2) returning *",
      [station_name, schedule_id]
    );
    return res.status(201).json({
      status_code: 200,
      message: "Station created successfully !",
      data: {
        station: rows[0],
      },
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ error: "Internal Server Error" });
  }
};
