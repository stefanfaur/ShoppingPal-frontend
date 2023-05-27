# ShoppingPal

ShoppingPal is a project designed to help users keep track of their spending by letting them save receipts details by taking a picture and then getting useful statistics about thei spendings. The project is built using Flutter and Firebase on the frontend. 
The backend is build using FastAPI and PostgreSQL and its repo can be found [here.](https://github.com/stefanfaur/ShoppingPal-backend)

# ShoppingPal Documentation Table of Contents

1.  [Project Requirements](#project-requirements)
2.  [Project Structure](#project-structure)
3.  [Overview](#overview)
    -   [ShoppingList Page](#shoppinglistpage)
    -   [Preview Page](#previewpage)
    -   [getUserID](#getuserid)
    -   [Login Page](#loginpage)
    -   [Main Page](#mainpage)
    -   [Auth Page](#authpage)
    -   [Photo Page](#photopage)
    -   [Show Items](#showitems)
    -   [Save Receipt](#savereceipt)
    -   [Image Service](#imageservice)
    -   [Firebase Auth](#firebaseauth)
4.  [Integration with the Backend API](#integration-with-the-backend-api)

## Project Requirements

To run the project, make sure you have Flutter installed. We recommend using `Visual Studio Code` with the `Flutter` extension. The following are necessary to set up the project:

1.  **Install Flutter:** You can find the installation guide [here](https://flutter.dev/docs/get-started/install).
    
2.  **Verify Flutter Installation:** After installing Flutter, run the following command to verify that Flutter is installed and configured correctly:
```
flutter doctor
```
 Make sure that the `flutter doctor` command does not output any errors or warnings. If any issues are reported, resolve them before proceeding.
    
3.  **Clone the Project Repository:** Run the following command to clone the project repository:
```
git clone https://github.com/stefanfaur/ShoppingPal-frontend
```
4. **Navigate to the Project Directory:** Change your working directory to the project folder:
```
cd shoppingpal
```
5. **Fetch Dependencies:** Next, fetch the project dependencies:
```
flutter pub get
```
6. **Run the Project:** Finally, start the application:
```
flutter run
```
This command will launch the application in a connected device or emulator.

## Project Structure
We used the recommended Flutter app structure.
```
.
├── README.md
├── fonts
│   └── Roboto-Medium.ttf
├── lib
│   ├── main.dart
│   ├── pages
│   │   ├── account.dart
│   │   ├── auth_page.dart
│   │   ├── getUserID.dart
│   │   ├── login_page.dart
│   │   ├── main_page.dart
│   │   ├── photo.dart
│   │   ├── preview.dart
│   │   ├── shopping_list.dart
│   │   ├── showItems.dart
│   │   ├── signup_page.dart
│   │   └── utils.dart
│   └── services
│       ├── get_receipt_info.dart
│       ├── get_user_info.dart
│       ├── get_user_receipts.dart
│       ├── image.dart
│       ├── save_receipt.dart
│       └── signup_to_db.dart
├── pubspec.yaml
└── test
    └── widget_test.dart
```

## Overview

The project consists of several key components:

1.  **ShoppingListPage**: This is the main page of the app where users can view their saved receipts. It fetches the user's receipts from the database and displays them in a list. Each receipt can be clicked to view its details.
    
2.  **PreviewPage**: This page is used to preview the details of a receipt before saving it. It fetches the content from the JSON file, reads the merchant name, date, total, and items, and displays them for the user to review.
    
3.  **getUserID**: This is a utility class that fetches the current user's ID and email from Firebase Auth.
    
4.  **LoginPage**: This page is used for user authentication. It allows users to sign in using their email and password.
    
5.  **MainPage**: This is the root of the app. It initializes Firebase and sets up the main MaterialApp.
    
6.  **AuthPage**: This page handles user authentication. It allows users to sign in or sign up.
    
7.  **PhotoPage**: This page allows users to take a picture of their receipt, which is then processed and saved.
    
8.  **ShowItems**: This page displays the items from a specific receipt.
    
9.  **SaveReceipt**: This service is responsible for saving the receipt details to the database.
    
10.  **ImageService**: This service handles the image processing part of the app.
    
11.  **FirebaseAuth**: This is used for user authentication.

## ShoppingListPage

The `ShoppingListPage` is the main page of the app where users can view their saved receipts. It fetches the user's receipts from the database and displays them in a list. Each receipt can be clicked to view its details.

-   `getUserReceiptList()`: This method fetches the user's receipts from the database. It uses the `getUserReceipts()` method from the `getUserReceipts` service and the `getUID()` method from the `getUserID` utility class.
    
-   `switchScreen()`: This method navigates to the `ShowItems` page, passing the ID of the selected receipt.
    
-   `initState()`: This method is called when this page is created. It fetches the user's ID and email and then fetches the user's receipts.
    
-   `build()`: This method builds the UI of the page. It creates a `ListView.builder` that generates a list of cards, each representing a receipt. Each card displays the shop name, date, and total of the receipt and can be clicked to view the receipt's details.
    

The `CustomListButton` widget is used to create each card. It takes the index of the receipt, the list of receipts, the shop name, date, and total of the receipt, and a callback function to be called when the card is clicked.

  
## PreviewPage

The `PreviewPage` is used to preview the details of a receipt before saving it. It fetches the content from the JSON file, reads the merchant name, date, total, and items, and displays them for the user to review.

-   `readJson()`: This method fetches content from the JSON file. It uses the `uploadImage()` method from the `image` service and the `get_image()` method from the `photo` page.
    
-   `list_to_json()`: This method converts a list of items to a JSON string. It parses the quantity and unit price of each item to a double and then creates a map with the merchant name, date, total, and items.
    

## getUserID

The `getUserID` is a utility class that fetches the current user's ID and email from Firebase Auth.

-   `getUID()`: This method fetches the current user's ID from Firebase Auth.
    
-   `getUserEmail()`: This method fetches the current user's email from Firebase Auth.
    

## LoginPage

The `LoginPage` is used for user authentication. It allows users to sign in using their email and password.

-   `signIn()`: This method signs in the user using their email and password. It uses the `signInWithEmailAndPassword()` method from Firebase Auth and the `createUser()` method from the `signup_to_db` service. If the sign-in process fails, it shows a snack bar with the error message.
## MainPage

The `MainPage` is the root of the app. It initializes Firebase and sets up the main MaterialApp.

## AuthPage

The `AuthPage` handles user authentication. It allows users to sign in or sign up.

-   `toggle()`: This method toggles between the login and sign-up pages. If the user is on the login page, it switches to the sign-up page, and vice versa.

## PhotoPage

The `PhotoPage` allows users to take/insert a picture of their receipt, which is then processed and saved.

## ShowItems

The `ShowItems` page displays the items from a specific receipt. 

## SaveReceipt

The `SaveReceipt` service is responsible for saving the receipt details to the database. It is used in the `PreviewPage` to upload the receipt details after they have been reviewed by the user.

-   `uploadReceipt()`: This method uploads the receipt details to the database. It takes a JSON string of the receipt details and the user's ID as arguments. It uses the `saveReceipt()` method from the `save_receipt` service.

## ImageService

The `ImageService` handles the image processing part of the app. It is used in the `PhotoPage` to process the image of the receipt and convert it to a format that can be uploaded to the database.

-   `getImage()`: This method allows the user to take a picture or select an image from their device. It uses the `ImagePicker` plugin to access the device's camera or gallery.
    
-   `saveFilePermanently()`: This method saves the image file permanently on the device. It takes the path of the image file as an argument and copies the file to the application's documents directory.

## FirebaseAuth

FirebaseAuth is used for user authentication. It is used in both the `LoginPage` and `AuthPage` for signing in and signing up users respectively.

-   `signIn()`: This method signs in the user using their email and password. It uses the `signInWithEmailAndPassword()` method from Firebase Auth. If the sign-in process fails, it shows a snack bar with the error message.
    
-   `signUp()`: This method signs up the user using their email and password. It uses the `createUserWithEmailAndPassword()` method from Firebase Auth. If the sign-up process fails, it shows a snack bar with the error message.
    
-   `authStateChanges()`: This method returns a Stream of `User` objects representing the user's authentication state. It is used in the `MainPage` to switch between the `MainPage` and `AuthPage` depending on whether the user is signed in or not.

## Integration with the Backend API

The ShoppingPal app integrates with a backend API to perform various operations such as fetching user receipts, saving receipts, uploading images, and managing user information.

Here is a brief overview of the API integrations:

-   **Fetching User Receipts**: The `getUserReceipts()` function sends a GET request to the `/receipts/{userId}` endpoint to fetch the user's receipts.
    
-   **Saving Receipts**: The `saveReceipt()` function sends a POST request to the `/save-receipt/?user_id={userId}` endpoint to save a receipt. The receipt details are sent in the request body as a JSON string.
    
-   **Uploading Images**: The `uploadImage()` function sends a POST request to the `/upload-image/` endpoint to upload an image. The image file is sent as a multipart file in the request body.
    
-   **Creating User**: The `createUser()` function sends a POST request to the `/users/` endpoint to create a user. The user's ID and email are sent in the request body as a JSON string.
    
-   **Fetching User Information**: The `getUserInfo()` function sends a GET request to the `/users/{userId}` endpoint to fetch the user's information.
    
-   **Fetching Receipt Information**: The `getReceiptInfo()` function sends a GET request to the `/receipts/{receiptId}/items` endpoint to fetch the items of a specific receipt.
    

All these functions use the `http` package to send HTTP requests and the `dart:convert` package to encode and decode JSON data. The responses from the API are parsed and returned as a `Map<String, dynamic>`.
