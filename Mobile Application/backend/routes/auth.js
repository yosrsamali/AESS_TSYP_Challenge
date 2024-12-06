import express from 'express';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import User from '../models/User.js';
import authMiddleware from '../middlewares/authMiddleware.js';
const router = express.Router();

router.post('/signup', async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = new User({ email, password });
    await user.save();
    res.status(201).json({ message: 'User created' });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

router.post('/signin', async (req, res) => {
    try {
      const { email, password } = req.body;
  
      if (!password || password.trim() === "") {
        return res.status(400).json({ error: 'Password is required' });
      }
  
      const user = await User.findOne({ email });
      if (!user) {
        return res.status(401).json({ error: 'Invalid credentials' });
      }
  
      console.log('Entered Password:', password);
      console.log('Stored Hashed Password:', user.password);
  
      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch) {
        return res.status(401).json({ error: 'Invalid credentials' });
      }
  
      const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '1d' });
      return res.status(200).json({ token });
      
    } catch (err) {
      console.error('Login error:', err);
      return res.status(401).json({ error: 'Authentication failed' });
    }
  });
router.post("/reset-password", async (req, res) => {
    const { email, newPassword } = req.body;
  
    try {
      const user = await User.findOne({ email });
      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }
  
      const hashedPassword = await bcrypt.hash(newPassword, 10);
      user.password = hashedPassword;
      await user.save();
  
      res.json({ message: "Password reset successful" });
    } catch (error) {
      res.status(500).json({ message: "Error resetting password", error });
    }
  });

  router.post('/change-password', authMiddleware, async (req, res) => {
    if (!req.user || !req.user.id) {
      return res.status(400).json({ error: 'User not authenticated' });
    }
  
    const { currentPassword, newPassword } = req.body;
  
    try {
      const user = await User.findById(req.user.id);
      if (!user) {
        return res.status(404).json({ error: 'User not found' });
      }
      
      const isMatch = await bcrypt.compare(currentPassword, user.password);
      if (!isMatch) {
        return res.status(400).json({ error: 'Current password is incorrect' });
      }
  
      const hashedPassword = await bcrypt.hash(newPassword, 10);
      user.password = hashedPassword;
      await user.save();
      res.json({ message: 'Password updated successfully' });
    } catch (error) {
      res.status(500).json({ error: 'Error updating password' });
    }
  });
  
  
  
export default router;

