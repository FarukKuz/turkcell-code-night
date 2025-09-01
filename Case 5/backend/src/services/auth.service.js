const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

async function register({ customer_name, email, password }) {
  const hashed = await bcrypt.hash(password, 10);
  return prisma.customer.create({
    data: { customer_name, email, password: hashed }
  });
}

async function login({ email, password }) {
  const user = await prisma.customer.findUnique({ where: { email } });
  if (!user) throw new Error("User not found");

  const match = await bcrypt.compare(password, user.password);
  if (!match) throw new Error("Invalid password");

  // JWT oluştur
  return jwt.sign({ userId: user.customer_id }, process.env.JWT_SECRET, { expiresIn: "10h" });
}

async function me(authHeader) {
  if (!authHeader) throw new Error("No token provided");
  const token = authHeader.split(" ")[1];
  const decoded = jwt.verify(token, process.env.JWT_SECRET);
  return prisma.customer.findUnique({ where: { customer_id: decoded.userId } });
}

module.exports = { register, login, me };