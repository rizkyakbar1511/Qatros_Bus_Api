const db = require("../config/db.config");

exports.findAll = async (req, res) => {
  try {
    const { rows } = await db.query(
      "SELECT bus_name, station_name, departure_time, arrival_time, destination, estimated FROM busses b INNER JOIN stations s ON s.id = b.station_id INNER JOIN schedules sc ON sc.id = s.schedule_id"
    );
    return res.status(200).json({
      status_code: 200,
      message: "success",
      results: rows.length,
      data: {
        busses: rows,
      },
    });
  } catch (error) {
    return res.status(500).json({ error: "Internal Server Error" });
  }
};

exports.findById = async (req, res) => {
  try {
    const { id } = req.params;
    const { rows } = await db.query("SELECT * FROM busses WHERE id = $1", [id]);
    if (rows.length === 0) {
      return res.status(403).json({
        status_code: 404,
        message: `Oops! bus not found`,
      });
    }
    return res.status(200).json({
      status_code: 200,
      message: `Bus found !`,
      results: rows.length,
      data: {
        busses: rows[0],
      },
    });
  } catch (error) {
    return res.status(500).json({ error: "Internal Server Error" });
  }
};

exports.create = async (req, res) => {
  try {
    const { bus_name, station_id } = req.body;
    console.log(req.file);
    const {
      rows,
    } = await db.query(
      "INSERT INTO busses (bus_name,bus_photo, station_id) VALUES ($1, $2, $3) returning *",
      [bus_name, req.file.path, station_id]
    );
    return res.status(201).json({
      status_code: 200,
      message: "Bus created successfully !",
      data: {
        busses: rows[0],
      },
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ error: "Internal Server Error" });
  }
};

exports.update = async (req, res) => {
  try {
    const { bus_name, station_id } = req.body;
    const { id } = req.params;
    const {
      rows,
    } = await db.query(
      "UPDATE busses SET bus_name=$1,station_id=$2 WHERE id=$3 returning *",
      [bus_name, station_id, id]
    );
    if (rows.length === 0) {
      return res.status(400).json({
        status_code: 400,
        message: "failed, please provide a correct bus id !",
      });
    }
    return res.status(200).json({
      status_code: 200,
      message: `Bus updated successfully !`,
      data: {
        products: rows[0],
      },
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ error: "Internal Server Error" });
  }
};

exports.remove = async (req, res) => {
  try {
    const { id } = req.params;
    const { rows } = await db.query("SELECT * FROM busses WHERE id = $1", [id]);
    if (rows.length === 0) {
      return res.status(400).json({
        status_code: 400,
        message: "failed, please provide a correct bus id !",
      });
    }
    await db.query("DELETE FROM busses WHERE id = $1", [id]);
    return res.status(200).json({
      status_code: 200,
      message: `Bus with id : ${id} deleted`,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ error: "Internal Server Error" });
  }
};
