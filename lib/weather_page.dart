import 'package:dbtest/weather/forecast_data.dart';
import 'package:dbtest/weather/weather_data.dart';
import 'package:dbtest/weather/weather_item.dart';
import 'package:dbtest/weather/weather_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:async';

class WeatherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    //throw UnimplementedError();
    return _WeatherPageState();
  }
}

class _WeatherPageState extends State {
  bool isLoading = false;
  WeatherData? weatherData;
  ForecastData? forecastData;

  GestureDetector? _gestureDetector;

  @override
  void initState() {
    super.initState();

    loadWeather();
  }

  loadWeather() async {
    setState(() {
      isLoading = true;
    });

    final lat = 28.2096;
    final lon = 83.9856;
    final weatherResponse = await http.get(
       Uri.parse( 'https://api.openweathermap.org/data/2.5/weather?APPID=5c50753f8568f769c3046f1f1ad2399a&lat=${lat.toString()}&lon=${lon.toString()}'));
    final forecastResponse = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/forecast?APPID=5c50753f8568f769c3046f1f1ad2399a&lat=${lat.toString()}&lon=${lon.toString()}'));

    if (weatherResponse.statusCode == 200 &&
        forecastResponse.statusCode == 200) {
      return setState(() {
        weatherData = WeatherData.fromJson(jsonDecode(weatherResponse.body));
        forecastData = ForecastData.fromJson(jsonDecode(forecastResponse.body));
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Page',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.lightBlueAccent,
          body: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: weatherData != null
                        ? Weather(weather: weatherData)
                        : Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isLoading
                        ?const CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : IconButton(
                            icon:const Icon(Icons.refresh),
                            tooltip: 'Refresh',
                            onPressed: loadWeather,
                            color: Colors.white,
                          ),
                  ),
                  /*Container(
                            padding: EdgeInsets.all(8.0),
                            child:
                              isLoading ? CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor: AlwaysStoppedAnimation(Colors.white),):GestureDetector(
                              onVerticalDragDown: (DragDownDetails details){
                                loadWeather;
                              },
                            ),

                          )*/
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 200.0,
                  child: forecastData != null
                      ? ListView.builder(
                          itemCount: forecastData!.list.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => WeatherItem(
                              weather: forecastData!.list.elementAt(index)))
                      : Container(),
                ),
              ),
            ),
          ]))),
    );
  }
}
