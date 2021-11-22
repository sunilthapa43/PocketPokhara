import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'weather_data.dart';
   

    // changed weather.name to string
class WeatherItem extends StatelessWidget {
  final WeatherData? weather;
  WeatherItem({Key? key, @required this.weather}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(weather!.name.toString(), style:const TextStyle(color: Colors.black)),
            Text(weather!.main.toString(),
                style:const TextStyle(color: Colors.black, fontSize: 24.0)),
            Text('${((weather!.temp)! / 10).toStringAsFixed(1)}°C',
                style: TextStyle(color: Colors.black)),
            Image.network(
                'https://openweathermap.org/img/w/${weather!.icon}.png'),
            Text(DateFormat.yMMMd().format(weather!.date as DateTime),
                style:const TextStyle(color: Colors.black)),
            Text(DateFormat.Hm().format(weather!.date as DateTime),
                style: const TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
