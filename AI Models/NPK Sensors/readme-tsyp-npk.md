# Soil Health Prediction Model

This project predicts whether soil is healthy or not based on its characteristics, using a Support Vector Machine (SVM) classifier. The model leverages features such as pH level, organic matter, and nutrient content to make predictions.

---

## Table of Contents
1. [Project Overview](#project-overview)
2. [Dataset Description](#dataset-description)
3. [Installation](#installation)
4. [Usage](#usage)
5. [Model Description](#model-description)
6. [Performance](#performance)
7. [Example Prediction](#example-prediction)

---

## Project Overview

Soil health is crucial for sustainable agriculture. This project aims to assist in analyzing soil health using machine learning. The implemented model uses soil characteristics to classify soil as either **healthy** or **not healthy**.

---

## Dataset Description

### Features
The following features are used:
- **pH Level**: Acidity/alkalinity of the soil.
- **Organic Matter (%)**: Percentage of organic materials in the soil.
- **Nitrogen Content (kg/ha)**: Amount of nitrogen per hectare.
- **Phosphorus Content (kg/ha)**: Amount of phosphorus per hectare.
- **Potassium Content (kg/ha)**: Amount of potassium per hectare.

### Target
- **Healthy**: Binary label (`0` = Not Healthy, `1` = Healthy).

The dataset should be provided in a CSV format.

---

## Installation

1. Clone this repository:
    ```bash
    git clone https://github.com/your-repo-name/soil-health-prediction.git
    ```
2. Install the required dependencies:
    ```bash
    pip install -r requirements.txt
    ```

---

## Usage

1. Place your dataset (`.csv` file) in the project directory.
2. Update the dataset path in the notebook:
    ```python
    soil_data = pd.read_csv('path_to_your_data.csv')
    ```
3. Run the notebook to train the model and evaluate its performance.

### Example: Making a Prediction
To predict soil health for new data, input the soil characteristics in the following format:
```python
new_data = pd.DataFrame({
    'pH Level': [6.5], 
    'Organic Matter (%)': [4.2],
    'Nitrogen Content (kg/ha)': [120],
    'Phosphorus Content (kg/ha)': [15],
    'Potassium Content (kg/ha)': [300]
})
