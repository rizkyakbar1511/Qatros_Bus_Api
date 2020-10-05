const db = require("../config/db.config");

exports.create = async (req, res) => {
  try {
    const { departure_time, arrival_time, destination } = req.body;
    const countDays = await db.query("SELECT AGE($1, $2)", [
      arrival_time,
      departure_time,
    ]);
    const estimated = countDays.rows[0].age.days.toString();
    const {
      rows,
    } = await db.query(
      "INSERT INTO schedules (departure_time, arrival_time, destination, estimated ) VALUES ($1, $2, $3, $4) returning *",
      [departure_time, arrival_time, destination, `${estimated} days`]
    );
    return res.status(201).json({
      status_code: 200,
      message: "Schedule created successfully !",
      data: {
        schedule: rows[0],
      },
    });
  } catch (error) {
    return res.status(500).json({ error: error });
  }
};
