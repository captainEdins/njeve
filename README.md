# 🔖Njeve

### Njeve, meaning "cold" in Kenyan slang, is your go-to app for staying informed about the weather.

This app provides real-time weather updates, keeping you prepared for whatever
Mother Nature throws your way. Plus, Njeve's handy offline features ensure you have access
to the latest forecast, even without an internet connection.

## Project Screenshots

**Here's a glimpse of what this project offers:**

| Splash Screen                                 | Landing Page                                 | Landing Page                                 | Landing Page                                 | Permission Request Toast                     |
|-----------------------------------------------|----------------------------------------------|----------------------------------------------|----------------------------------------------|----------------------------------------------|
| ![Screenshot 1](images/screenshot/splash.jpg) | ![Screenshot 2](images/screenshot/land1.jpg) | ![Screenshot 3](images/screenshot/land2.jpg) | ![Screenshot 4](images/screenshot/land3.jpg) | ![Screenshot 5](images/screenshot/toast.jpg) |

| Permission Request                                | Permission Error                               | Sunny View                                 | Moon View                                    | Rainy View                                   |
|---------------------------------------------------|------------------------------------------------|--------------------------------------------|----------------------------------------------|----------------------------------------------|
| ![Screenshot 6](images/screenshot/permission.jpg) | ![Screenshot 7](images/screenshot/decline.jpg) | ![Screenshot 8](images/screenshot/sun.jpg) | ![Screenshot 9](images/screenshot/night.jpg) | ![Screenshot 10](images/screenshot/rain.jpg) |



## Key Features

To improve the user experience and reduce data usage, the app implements the following features:

 - **Offline data caching:** Weather data is cached for 5 hours after it's retrieved, 
allowing users to interact with the app even without an internet connection. 
This saves users data by displaying the most recent data available.
 - **Refresh option:** Users can manually refresh the data by clicking the arrow next 
to their address, ensuring they have the latest information whenever they need it.

### Benefits:

 - **Reduced data consumption:** By caching data, users can avoid unnecessary data downloads,
especially beneficial for those with limited data plans.
 - **Improved user experience:** Offline data access allows users to view weather information
even when offline.
 - **Cost savings:** Reduced API calls lead to lower subscription costs for the app.

## Download Njeve
 - [Download From Google Drive](https://drive.google.com/file/d/1v7HPINARBm1BpcrURCD9UdW9H6RvFtwe/view?usp=sharing)
 - [Download From Diawi](https://i.diawi.com/vqGzg3)

## Dependencies
This app utilizes the following external libraries to provide various functionalities:

 - **shared_preferences:** Enables storing and retrieving persistent data on the device.
 - **smooth_page_indicator:** Provides a visual indicator for navigating through pages or items. (Version: ^1.0.0+2)
 - **permission_handler:** Manages runtime permissions required by the app on Android devices. (Version: ^8.3.0)
 - **geolocator:** Facilitates accessing the device's location information. (Version: ^8.0.1)
 - **intl:** Offers internationalization and localization support for handling different languages and formats. (Version: ^0.17.0)
 - **lottie:** Enables displaying animated Lottie animations within the app. (Version: ^1.2.1)
 - **geocoding:** Assists with converting addresses or locations into geographical coordinates. (Version: ^3.0.0)
 - **http:** Provides a client for making HTTP requests to web servers. (Version: ^0.13.5)
 - **loading_animation_widget:** (Optional) Likely a custom package for handling loading animations within the app. (Version: ^1.2.0+2)


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
