import mongoose from 'mongoose';

const ModelOutputSchema = new mongoose.Schema({
  double_planter: { type: Number, required: true },
  weed_cluster: { type: Number, required: true },
  standing_water: { type: Number, required: true },
  updatedAt: { type: Date, default: Date.now },
});

export default mongoose.model('ModelOutput', ModelOutputSchema);
