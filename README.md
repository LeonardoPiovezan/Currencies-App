# Currencies-App

### Summary

- [Requirements](#requirements)
- [Installation](#installation)
- [Description](#description)

## Requirements
- Xcode installed
- CocoaPods

## Installation

Run this command in terminal:
```
pod install
```
If you'd like to install the app, you can use the following TestFlight link:
https://testflight.apple.com/join/KK8rariD

## Description
This app shows a list of currencies. The first one is the base one, that you can type values and see their conversion into other currencies.
If you tap other currencies, they will become the base one.
Each 1 second the App gets new currency rates from the API.

This application was developed using MVVM-C.
The views were created using only code.
One module in the app is basically composed by 3 files:

- View: It is the viewController, responsible to handle the lifecycle of the app and intermediate the viewModel and the viewScreen

- ViewModel: It is the file that holds the logics and transformation of data. 

- ViewScreen: It is a class that defines the construction of the View. No logic is held on that. 

The classes are binded using closures that also helps on the asyncronous calls.

The navigation flow is using a Coordinator class, that is responsible for 
show the modules.

Swinject is used in this project for dependency injection.

For the unit tests Quick and Nimble were used due to the Spec structure and easy readability.

The TestFlight version was created with the help of Fastlane.
Best Regards,

Leonardo Augusto Piovezan
