const authService = require("../services/auth.service");

async function register(req, res) {
  try {
    const user = await authService.register(req.body);
    res.json(user);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
}

async function login(req, res) {
  try {
    const token = await authService.login(req.body);
    res.json({ token });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
}

async function me(req, res) {
  try {
    const user = await authService.me(req.headers.authorization);
    res.json(user);
  } catch (err) {
    res.status(401).json({ error: err.message });
  }
}

module.exports = { register, login, me };
