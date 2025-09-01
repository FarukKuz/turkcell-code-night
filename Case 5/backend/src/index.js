require("dotenv").config();
const express = require("express");
const authRoutes = require("./routes/auth.routes");

const app = express();
app.use(express.json());

// Auth route'larını ana uygulamaya ekle
app.use("/auth", authRoutes);

app.get('/', (req, res) => {
  res.send('API çalışıyor!');
});

app.listen(3000, () => {
  console.log("🚀 Server running at http://localhost:3000");
});