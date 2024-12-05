# Multispectral and RGB Image Classification

This project focuses on developing and evaluating deep learning models for the classification of multispectral and RGB images. Using advanced convolutional neural networks (CNNs), the project encompasses multiple stages, including data preprocessing, model construction, training, and performance evaluation. Additionally, various techniques such as Saliency Maps, Grad-CAM, and Grad-CAM++ are used to interpret and visualize the models' decisions.

---

## Table of Contents
1. [Project Overview](#project-overview)
2. [Project Structure](#project-structure)
3. [Data Preprocessing and Dataset Preparation](#data-preprocessing-and-dataset-preparation)
4. [Building the RGB CNN Model](#building-the-rgb-cnn-model)
5. [Training and Saving the RGB CNN Model](#training-and-saving-the-rgb-cnn-model)
6. [Visualizing Model Performance for RGB CNN](#visualizing-model-performance-for-rgb-cnn)
7. [Building the Multispectral CNN Model](#building-the-multispectral-cnn-model)
8. [Training and Saving the Multispectral CNN Model](#training-and-saving-the-multispectral-cnn-model)
9. [Visualizing Model Performance for Multispectral CNN](#visualizing-model-performance-for-multispectral-cnn)
10. [Dependencies](#dependencies)
11. [Model Evaluation and Results](#model-evaluation-and-results)
12. [Model Saving and Deployment](#model-saving-and-deployment)
13. [Future Work and Improvements](#future-work-and-improvements)
14. [Acknowledgments](#acknowledgments)

---

## Project Overview

This project aims to classify multispectral and RGB images using deep learning models. The RGB model works with 3-channel images (Red, Green, Blue), while the multispectral model processes images with 12 spectral bands. We leverage Convolutional Neural Networks (CNNs) for this classification task, and employ advanced visualization techniques such as Saliency Maps, Grad-CAM, and Grad-CAM++ to better understand and interpret model predictions.

---

## Project Structure

The project is divided into the following parts:
- **Part 1**: Data Preprocessing and Dataset Preparation
- **Part 2**: Building the RGB CNN Model
- **Part 3**: Training and Saving the RGB CNN Model
- **Part 4**: Visualizing Model Performance for RGB CNN
- **Part 5**: Building the Multispectral CNN Model
- **Part 6**: Training and Saving the Multispectral CNN Model
- **Part 7**: Visualizing Model Performance for Multispectral CNN

Each part builds upon the previous one, culminating in a fully functional model capable of classifying RGB and multispectral images and visualizing its decisions.

---

## Data Preprocessing and Dataset Preparation

The project uses both RGB and multispectral image datasets.

- **RGB Dataset**: Contains images with 3 channels—Red, Green, and Blue—commonly used for color-based image analysis.
- **Multispectral Dataset**: Includes 12 spectral bands, offering a more detailed view of the image features beyond visible light.

Both datasets are split into training and validation sets for model evaluation.

---

## Building the RGB CNN Model

The RGB CNN model is designed to classify 3-channel RGB images. The architecture consists of:
- A multichannel CNN function to handle RGB input.
- Dense hidden layers with 512 units.
- Transfer learning is used by initializing the model with pre-trained ImageNet weights to improve performance.

---

## Training and Saving the RGB CNN Model

- The RGB CNN model is compiled with the Adam optimizer, using a learning rate of 0.001, and sparse categorical cross-entropy loss.
- The model is trained using the RGB training dataset for a specified number of epochs, with validation on the RGB validation dataset.
- After training, the model is saved as `RGB_CNN.h5` for future use.

---

## Visualizing Model Performance for RGB CNN

To better understand the model’s predictions, several visualization techniques are employed:
- **Saliency Map**: Highlights key image features influencing the model's decision.
- **Grad-CAM**: Displays areas in the image contributing the most to the decision.
- **Grad-CAM++**: An enhanced version of Grad-CAM that provides more accurate localization.

These visualizations are generated for images from the RGB validation set to interpret model behavior.

---

## Building the Multispectral CNN Model

The multispectral CNN model follows a similar structure to the RGB CNN model but is designed to handle 12 input channels:
- Multichannel CNN layers for the 12 spectral bands.
- Dense layers with 512 units for feature extraction.
- The model is compiled with the SGD optimizer (learning rate = 0.0001, momentum = 0.0) and sparse categorical cross-entropy loss.

---

## Training and Saving the Multispectral CNN Model

The multispectral CNN model is trained on the multispectral training dataset for a predefined number of epochs. Validation is conducted on the multispectral validation set. After training, the model is saved as `S2_CNN.h5`.

---

## Visualizing Model Performance for Multispectral CNN

Similar to the RGB CNN model, visualizations are created to interpret the multispectral model:
- **Saliency Maps**: To highlight important regions of the image.
- **Grad-CAM**: To show areas influencing the model's predictions.
- **Grad-CAM++**: Provides more detailed visualizations.

These techniques are applied to the multispectral validation set.

---

## Dependencies

The following libraries are required to run the project:
- **TensorFlow/Keras**: For building and training deep learning models.
- **Matplotlib**: For visualizing model results.
- **NumPy**: For numerical operations and array manipulations.
- **Custom Visualization Functions**: Includes functions like `get_saliency`, `get_gradcam`, and `get_gradcam_plus`.

---

## Model Evaluation and Results

After training, the models are evaluated using the validation datasets. Key metrics like accuracy, F1 score, recall, and precision are computed to assess the model's performance on both RGB and multispectral images. The visualizations also provide insight into how the model makes its decisions.

---

## Model Saving and Deployment

Once training is complete, both models (RGB and multispectral) are saved as `.h5` files in the `CNN_models` directory. These models can be loaded for future inference or further analysis.

---

## Future Work and Improvements

- Hyperparameter tuning can be explored to improve model performance.
- Advanced data augmentation techniques can be applied to increase data diversity and help the models generalize better.
- Future work may involve exploring hybrid models that combine RGB and multispectral data for enhanced classification accuracy.

---

## Acknowledgments

Special thanks to the TensorFlow community for providing pre-trained models, optimization tools, and resources that helped in developing this project. The datasets used are publicly available, and the contributions of the TensorFlow community are greatly appreciated.
