# log_pixie

## Description
log_pixie is a powerful logging library designed to simplify logging in your applications. It provides a lightweight and intuitive API for logging messages with different levels of severity.

## Features
- Easy to use: log_pixie offers a simple and straightforward API, making it easy to integrate into your projects.
- Multiple log levels: log_pixie supports different log levels, including  INFO, WARNING, and ERROR, NETWORK allowing you to control the verbosity of your logs.


## Installation
To install log_pixie, follow these steps:

1. Open your terminal or command prompt.
2. Navigate to your project directory.
3. Run the following command to install log_pixie via npm:

    
     flutter pub add log_pixie
    

## Usage

Import log_pixie into your project 

    
    import 'package:log_pixie/log_pixie.dart';
    

There are four available methods to log

    
     LogPixie.logInfo(String message, [Map<String, String>? data])
     LogPixie.logError(String error, [StackTrace? stackTrace])
     LogPixie.logWarning(String warning, [Map<String, String>? data])
     LogPixie.logNetwork(Map<String, dynamic>? data)
    

Also following http interceptors are available to add to your http client of choice

    
        PixieDioInterceptor();

    

If you are using http package then use ```HttpInterceptor``` to create the client or you can directly use ``` LogPixie.logNetwork(Map<String, dynamic>? data)``` method

## Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request on the log_pixie GitHub repository.

