import 'dart:convert';
import 'dart:typed_data';

import 'package:dbtest/description.dart';
import 'package:dbtest/image_test.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';


class Places extends StatefulWidget {
  const Places({Key? key}) : super(key: key);

  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  void showDescription(int id) {}
  final List<Map<String, dynamic>> places = [];

  int? id;
  bool isLoading = false;
  var connection = MySqlConnection.connect(
    ConnectionSettings(
      host: '10.0.2.2',
      port: 3306,
      user: 'root',
      db: 'pocketpokhara',
      password: null,
    ),
  );

  void getData() async {
    setState(() {
      isLoading = true;
    });
    final conn = await connection;
    Results result =
        await conn.query('select placeName , placeId, image1 from place');

    for (var data in result) {
      places.add({'placeName': data[0], 'placeId': data[1], 'image': data[2].toString()});
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Text('Loading')
        : ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding:const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              Place(places[index]['placeId'])));
                      print(places[index]['placeId']);
                    },
                    title: Text('${places[index]['placeName']}'),
                    trailing:const Icon(Icons.arrow_right),
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: places[index]['image'] == null
                            ? const Icon(Icons.image)
                            : Image.memory(
                                const Base64Decoder()
                                    .convert(places[index]['image']),
                                fit: BoxFit.fitWidth,
                              ),
                      ),
                    ),
                  ));
            },
          );
  }
  }

// pagination
