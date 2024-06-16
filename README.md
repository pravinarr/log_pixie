
# log_pixie

<img src="log_pixie_devtool/assets/log_pixie.png" width="128"/>

## Description
log_pixie is a simple logging tool for your applications during development. 


## Installation

    
     flutter pub add log_pixie
    
### Note

Eventhough you are adding this to you app's dependency, it will only work in debug mode.

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

