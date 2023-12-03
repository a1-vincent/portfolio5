const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();
const port = 5000;

app.use(cors());
app.use(express.json());

const connection = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "Duerenfedko0",
    database: "study_cafe_db"
});

//Get all cafes
app.get('/all/cafes',(req, res)=>{
    const query = 'SELECT * from cafes'

    connection.query(query, (error, results) =>{
        res.send(results)
    });
});

// Search cafe by ID
app.get('/cafes/:id', (req, res) => {
    const { id } = req.params;
    connection.query(`SELECT * FROM cafes WHERE id=${id}`, (error, cafe) => {
        if (error) {
            return res.status(500).send(error.message);
        }
        if (!cafe[0]) {
            return res.status(404).send("Cafe not found");
        }
        res.send(cafe[0]);
    });
});

// Create a new cafe
app.post('/cafes', (req, res) => {
    const { name, city, price_level } = req.body;

    if (!name || !city || !price_level) {
        return res.status(400).send("Invalid request. All fields are required.");
    }

    const insertCafe = `
        INSERT INTO cafes (name, city, price_level)
        VALUES (?, ?, ?)
    `;

    connection.query(insertCafe, [name, city, price_level], (error, result) => {
        if (error) {
            return res.status(500).send(error.message);
        }

        res.status(201).json({ id: result.insertId });
    });
});

// Get all users
app.get('/users', (req, res) => {
    connection.query("SELECT * FROM users", (error, users) => {
        if (error) {
            return res.status(500).send(error.message);
        }
        res.send(users);
    });
});

//Search by ID
app.get('/users/:id', (req, res) => {
    const { id } = req.params;
    connection.query(`SELECT * FROM users WHERE id=${id}`, (error, user) => {
        if (error) {
            return res.status(500).send(error.message);
        }
        if (!user[0]) {
            return res.status(404).send("User not found");
        }
        res.send(user[0]);
    });
});

//New user
app.post('/new/users', (req, res) => {
    const { username } = req.body;

    if (!username) {
        return res.status(400).send("Invalid request. Username is required.");
    }

    const insertUser = `
        INSERT INTO users (username, favorites)
        VALUES (?, ?)
    `;

    connection.query(insertUser, [username, ""], (error, result) => {
        if (error) {
            return res.status(500).send(error.message);
        }
        res.status(201).json({ id: result.insertId });
    });
});

app.post('/new/spot',(req,res)=>{
    const city = req.body.city;
    const name = req.body.name;


    connection.query('insert into spots (city, name) values (?,?)', [city, name])
    res.send("Successful POST request");
});

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
