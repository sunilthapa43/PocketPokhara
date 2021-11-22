import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'weather_data.dart';
import 'weather_item.dart';

class Weather extends StatelessWidget {
  final WeatherData? weather;

 const Weather({Key? key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(weather!.name.toString(), style:const TextStyle(color: Colors.white)),
        Text(weather!.main.toString(),
            style:const TextStyle(color: Colors.white, fontSize: 32.0)),
        Text('${((weather!.temp! / 10)).toStringAsFixed(0)}°C',
            style: const TextStyle(color: Colors.white)),
        Image.network('https://openweathermap.org/img/w/${weather!.icon}.png'),
        Text(DateFormat.yMMMd().format(weather!.date as DateTime),
            style: const TextStyle(color: Colors.white)),
        // Text(DateFormat.Hm().format(weather.date),
        //  style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
