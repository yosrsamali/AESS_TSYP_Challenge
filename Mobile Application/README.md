# aesschallenge

Overview
This project is a comprehensive system that includes a backend API and a frontend mobile application. The backend is built with Node.js, Express, and MongoDB to handle API requests, while the frontend is a Flutter mobile application that interacts with the backend to display the output of the AI model , providing a seamless user experience.

# Frontend: Flutter Mobile Application
Features
User Authentication: Sign up, login, and password reset functionalities.
Model Data Display: Displays values like double_planter, weed_cluster, and standing_water based on the model output from the backend.
Interactive UI: Graphical representation of data using percentage indicators.
Alert System: Displays alerts based on the fetched data (e.g., if values exceed thresholds).
Pull-to-Refresh: Users can refresh data by pulling down the screen.

frontend/                                             
├── android/                                          
├── ios/                                         
├── lib/                                                                               
│   ├── main.dart             
│   ├── screens/                                    
│   │   ├── HomePage.dart                                                
│   │   ├── DashboardScreen.dart                                                       
│   │   ├── AboutScreen.dart                                                     
│   │   ├── MainScreen.dart                                              
│   │   ├── ProfileScreen.dart                                           
│   │   ├── ChatbotScreen.dart                                                     
│   │   ├── ChangePasswordScreen.dart                                           
│   │   ├── ChangeLanguageScreen.dart                                              
│   │   ├── auth/                                          
│   │       ├── SignUpScreen.dart                                               
│   │       ├── SignInScreen.dart                        
│   │       └── ForgotPasswordScreen.dart                                      
│   ├── widgets/                                            
│   │   ├── custom_button.dart                                            
│   │   ├── custom_textfield.dart                                          
│   │   └── Rounded_Button.dart                                                       
├── pubspec.yaml             
├── assets/                  
│   ├── images/              
│   │   ├── logo.png          
│   │   └── same.jpg       
│   └── fonts/               
├── build/                  



# Backend: Node.js API
Features
Model Data Endpoint: Provides model data (e.g., double_planter, weed_cluster, and standing_water) to the frontend.
Environment Setup: The backend uses an .env file to securely store configuration details like API keys and database credentials.
Error Handling: Basic error handling for failed API requests.

backend/                                         
├── routes/                                                 
│   ├── auth.js                        
│   ├── modelOutput.js                              
│   └── profile.js                              
├── middlewares/                                 
│   ├── authMiddleware.js                                   
├── models/                                               
│   ├── User.js                                  
│   └── ModelOutput.js                                    
├── .env                                              
├── server.js                                    
└── package.json                                  

# How It Works
The Frontend (Flutter) communicates with the Backend API (Node.js/Express) to fetch model data and display it on the mobile application.
The Backend handles requests, processes them, and returns the necessary data to the frontend. It also uses an .env file to securely store sensitive data like API keys.


-- **Satelite Server** : you can download the server from this link : https://drive.google.com/drive/folders/1tb8CuQRKtsz2tDe3RHKZTSz6qNed0MaI?usp=sharing