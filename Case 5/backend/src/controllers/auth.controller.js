const authService = require("../services/auth.service");

async function register(req, res) {
  try {
    const { customer_name, email, password } = req.body;
    const user = await authService.register({ customer_name, email, password });
    res.status(201).json({
      status: true,
      messages: ["işlem başarılı"],
      code: 201,
      data: user
    });
  } catch (err) {
    res.status(400).json({
      status: false,
      messages: [err.message || "veriler girilirken bir hata oluştu."],
      code: 400,
      data: null
    });
  }
}

async function login(req, res) {
  try {
    const { email, password } = req.body;
    const token = await authService.login({ email, password });
    res.status(200).json({
      status: true,
      messages: ["Giriş başarılı"],
      code: 200,
      data: { token }
    });
  } catch (err) {
    res.status(401).json({
      status: false,
      messages: [err.message || "veriler girilirken bir hata oluştu."],
      code: 401,
      data: null
    });
  }
}

async function me(req, res) {
  try {
    const user = await authService.me(req.headers.authorization);
    res.status(200).json({
      status: true,
      messages: ["Kullanıcı bilgileri başarıyla alındı"],
      code: 200,
      data: user
    });
  } catch (err) {
    res.status(401).json({
      status: false,
      messages: [err.message || "veriler girilirken bir hata oluştu."],
      code: 401,
      data: null
    });
  }
}

module.exports = { register, login, me };