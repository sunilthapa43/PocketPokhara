// ignore_for_file: use_key_in_widget_constructors

// import 'package:flutter/material.dart'; 
// import 'package:mysql1/mysql1.dart';




// class Description extends StatefulWidget {

//  final int id ;
//  const Description(this.id);

//   @override
//   _DescriptionState createState() => _DescriptionState();
// }

// class _DescriptionState extends State<Description> {
//   var connection = MySqlConnection.connect(
//     ConnectionSettings(
//       host: '10.0.2.2',
//       port: 3306,
//       user: 'root',
//       db: 'pocketpokhara',
//       password: null,
//     ),
//   );


// void getData() async
// {
//   setState(() {
    
//   });
// var conn = await connection; 
// Results result = await conn.query('select placeName from place where id = ?' , [widget.id]);
// print(result.first);

// } 

//  @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getData();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
        
//         child:Column(children: [
//           Container(height: 
//           150,),
//       Row(
//             children: [
//         Container(child:const Text('ac'),),
//               Container(child:const Text('ac')),
//             ],
//           ),
//         ],)
      
      
      
      
//       ,),
      
//     );
//   }
// }



import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:typed_data';
import 'package:google_fonts/google_fonts.dart';
import 'package:mysql1/mysql1.dart';

import 'models/maps.dart';

class Place extends StatefulWidget {
  final int id;
  const Place(this.id);
  @override
  _PlaceState createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }
   var connection = MySqlConnection.connect(
    ConnectionSettings(
      host: '10.0.2.2',
      port: 3306,
      user: 'root',
      db: 'pocketpokhara',
      password: null,
    ),
  );


  
  final List<Map<String, dynamic>> places = [];

  bool isLoading = false;

  var imgList = [];
  String? img1;
  String? img2;
  String? img3;

//fetching the data from places table with the given id
  void fetchData() async {
    setState(() {
      isLoading = true;
    });
      var conn = await connection ;
      var result = await conn.query(
          'select placeId, placeName,description,latitude,longitude,image1,image2,image3 from place where placeId=?',
          [widget.id]);
      for (var data in result) {
        places.add({
          'placeId': data[0],
          'placeName': data[1],
          'description': data[2],
          'lat': data[3],
          'long': data[4],
          'img1': data[5].toString(),
          'img2': data[6].toString(),
          'img3': data[7].toString(),
        });
      }

      setState(() {
        isLoading = false;
      });

      print(widget.id);
      print(places.first['placeName']);
      img1 = places[0]['img1'];
      img2 = places[0]['img2'];
      img3 = places[0]['img3'];

      Uint8List a = const Base64Decoder().convert(img1.toString());
      Uint8List b = const Base64Decoder().convert(img2.toString());
      Uint8List c = const Base64Decoder().convert(img3.toString());

      imgList.add(a);
      imgList.add(b);
      imgList.add(c);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
        child: isLoading
            ?const Text('Loading')
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding:
                       const   EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.26),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  Container(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 400,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 2),
                        autoPlayAnimationDuration: Duration(milliseconds: 1000),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: imgList.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return isLoading
                                ? const CircularProgressIndicator()
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                       const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration:
                                       const BoxDecoration(color: Colors.amber),
                                    child: Image.memory(i,
                                        fit: BoxFit.cover, width: 1000));
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Text(
                        places[0]['placeName'],
                        style: GoogleFonts.oswald(
                            textStyle:const  TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                    ),
                  ),
                 const SizedBox(
                    width: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MapScreen(
                                  lat: places[0]['lat'] is double ? places[0]['lat']:28.2096 ,
                                  long: places[0]['long'] is double ? places[0]['long']:83.9856 ,)));
                        },
                        icon: const Icon(Icons.directions),
                        label:const  Text('')),
                  ),
               const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Text(
                        places[0]['description'].toString(),
                        style: GoogleFonts.amiri(
                            textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        )),
                      ),
                    ),
                  )
                ],
              ),
      )),
    );
  }
}
 