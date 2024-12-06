***Agricultural Satellite Image Classifier***
**Overview**
This project focuses on classifying and analyzing aerial farmland images to improve agricultural practices. Using a dataset from the Agriculture Vision Segmentation Challenge, the classifier identifies key patterns in farmland to provide actionable insights for better resource management and yield optimization.

**Dataset**
Images: 21,061 aerial images (512x512 resolution) with RGB and Near-Infrared (NIR) channels.
Annotations: Sparse masks highlighting key farmland regions.
Challenges:
Diverse patterns (shapes, textures, depths).
Sparse annotation coverage.
High computational demands due to large image size.

**Key Features Identified**
The model detects six critical patterns that influence crop yield:

*Cloud Shadow*: Obstructs satellite imaging clarity.
*Double Planter*: Overlapping crops indicate land-intensive farming.
*Planter Skip*: Missed planting rows highlight inefficiencies.
*Standing Water*: Identifies waterlogging that harms crops.
*Waterway*: Maps irrigation resources and ensures environmental sustainability.
*Weed Cluster*: Detects weeds that lower productivity.

**Business Value**
Agriculture faces increasing pressures due to population growth, requiring better resource efficiency and yield maximization. Satellite-based classification helps:

1. Monitor farmland conditions.
2. Identify factors like weeds, water, and planting inefficiencies.
3. Assist in long-term planning for sustainable farming practices.
4. Provide actionable data for better field management, benefiting farmers and researchers.


**Disclaimer**
Due to the computational resources required for training on this large dataset, we limited the number of epochs to 20 for this model. Increasing the number of epochs could further improve performance but was not feasible within the current resource constraints.

You can download the small version of the model here if you don't want to train it : https://drive.google.com/file/d/1-0MdmOiDvnFRtl_TNFzfA2rO6iI4AfDO/view?usp=sharing


