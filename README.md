
# log_pixie

<img src="log_pixie_devtool/assets/log_pixie.png" width="128"/>

## Description
log_pixie is a flutter devtool extension to show logs of your application during development. 

## Demo 

![log_pixie_demo](https://github.com/pravinarr/log_pixie/assets/8682635/dff783a3-43bf-4772-a438-394c7bd73813)


## Installation

    
     flutter pub add log_pixie
    
### Note

Eventhough you are adding this to you app's dependency, it will only work in debug mode.

Also you might be asked to enable the devtool after adding it to your project.

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

    

If you are using http package then use ```HttpInterceptor``` from this project to create the client or you can directly use ``` LogPixie.logNetwork(Map<String, dynamic>? data)``` method

## Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request on the log_pixie GitHub repository.

