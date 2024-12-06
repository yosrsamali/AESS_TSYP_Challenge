import express from 'express';
import mongoose from 'mongoose';
import dotenv from 'dotenv';
import bodyParser from 'body-parser';
import cors from 'cors';

dotenv.config();
const app = express();
app.use(bodyParser.json());
app.use(cors());

mongoose
  .connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('MongoDB Connected'))
  .catch((err) => console.error('MongoDB connection error:', err));

import authRoutes from './routes/auth.js';
import profileRoutes from './routes/profile.js';
import modelOutputRoutes from './routes/modelOutput.js';

app.use('/api/auth', authRoutes);
app.use('/api/profile', profileRoutes);
app.use('/api/model-output', modelOutputRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
