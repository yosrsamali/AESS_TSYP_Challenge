import express from 'express';
import authMiddleware from '../middlewares/authMiddleware.js';
import User from '../models/User.js';

const router = express.Router();

router.put('/change-password', authMiddleware, async (req, res) => {
  try {
    const { newPassword } = req.body;
    const user = await User.findById(req.user.id);
    user.password = newPassword;
    await user.save();
    res.status(200).json({ message: 'Password updated' });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

router.put('/change-language', authMiddleware, async (req, res) => {
  try {
    const { language } = req.body;
    const user = await User.findById(req.user.id);
    user.language = language;
    await user.save();
    res.status(200).json({ message: 'Language updated' });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

export default router;
