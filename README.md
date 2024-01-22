#  Forecast

The Forecast app will keep you up to date with the weather and forecasts in your area.

#  Description

A forecast app that shows the current weather and forecast for the next 5 days using location information.
It also shows additional information such as relative humidity, precipitation, atmospheric pressure, wind speed and direction.

#  Getting started

1. Make sure you have the Xcode version 14.0 or above installed on your computer.
2. Download the Forecast project files from the repository.
3. Open the project files in Xcode.
4. Run the active scheme.

#  Usage

To start getting weather updates, allow the app to use your location.
After getting your location, the app will show the weather in your area and a blue or yellow motion animation depending on whether it's raining, snowing, or sunny.
It will also show information about relative humidity, precipitation, atmospheric pressure, wind speed, and direction.
By selecting the Forecast tab, you will find the weather forecast for the next 5 days with 3 hour updates.

# Architecture

* Forecast project is implemented using the Model-View-ViewModel (MVVM) architecture pattern.
* Model has any necessary data or business logic needed to show the list and detail records.
* View is responsible for displaying the data to the user and leting him to interact with it.
* ViewModel is responsible for converting the data objects from the model in such a way they can be easily managed and presented.
* Project doesn't have a database.

# Dependencies

* 'Alamofire' is a networking library which ensures that the message reaches everyone in the world.
* 'XMLCoder' is a third party lib to help encode and decode XML data.
* 'Swinject' is a dependency injection framework that allows you to get loosely-coupled components in your app.

