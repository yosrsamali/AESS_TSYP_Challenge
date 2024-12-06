import express from 'express';
import ModelOutput from '../models/ModelOutput.js';

const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const modelOutput = await ModelOutput.findOne();
    if (!modelOutput) {
      return res.status(404).json({ error: 'Model output not found' });
    }
    res.status(200).json(modelOutput);
  } catch (err) {
    console.error('Error fetching model output:', err);
    res.status(500).json({ error: 'Error fetching model output' });
  }
});

router.put('/', async (req, res) => {
  const { double_planter, weed_cluster, standing_water } = req.body;
  try {
    const modelOutput = await ModelOutput.findOneAndUpdate(
      {},
      { double_planter, weed_cluster, standing_water, updatedAt: Date.now() },
      { new: true, upsert: true }
    );
    res.status(200).json(modelOutput);
  } catch (err) {
    console.error('Error updating model output:', err);
    res.status(500).json({ error: 'Error updating model output' });
  }
});
router.post('/', async (req, res) => {
    const { double_planter, weed_cluster, standing_water } = req.body;
  
    try {
      const newModelOutput = new ModelOutput({
        double_planter,
        weed_cluster,
        standing_water,
        createdAt: Date.now(),
        updatedAt: Date.now(),
      });
  
      const savedModelOutput = await newModelOutput.save();
  
      res.status(201).json(savedModelOutput); // Return the saved model output
    } catch (err) {
      console.error('Error adding model output:', err);
      res.status(500).json({ error: 'Error adding model output' });
    }
  });

export default router;
