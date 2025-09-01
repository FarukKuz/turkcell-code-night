require("dotenv").config();
const express = require("express");
const { PrismaClient } = require("@prisma/client");
const authRoutes = require("./routes/auth.routes");

const prisma = new PrismaClient();
const app = express();

app.use(express.json());

// Routes
app.use("/auth", authRoutes);

app.get('/', (req, res) => {
  res.send('API çalışıyor!');
});

app.listen(3000, () => {
  console.log("🚀 Server running at http://localhost:3000");
});
