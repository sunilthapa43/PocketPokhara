import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'dart:typed_data';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './places.dart';
import 'models/login.dart';

class ImageTest extends StatefulWidget {
  const ImageTest({Key? key}) : super(key: key);

  @override
  _ImageTestState createState() => _ImageTestState();
}

class _ImageTestState extends State<ImageTest> {
  // List places= [];
  // void _showPlaces() async{
  //  final _conn =  await connection;
  //  var results = _conn.query('select username from users');
  //  places.add(results);
  //  for(int i = 1 ; i<= places.length ; i++){
  //   print(places[i]);
  //  }
  // }

  bool isSendingData = false;
  Widget? message;
  bool isLoading = false;
  Widget? image;

  var connection = MySqlConnection.connect(
    ConnectionSettings(
      host: '10.0.2.2',
      port: 3306,
      user: 'root',
      db: 'pocketpokhara',
      password: null,
    ),
  );

  Future _insertImage() async {
    setState(() {
      isSendingData = true;
    });
    final conn = await connection;

    try {
      (_storedImage1 != null &&
              _storedImage2 != null &&
              _storedImage3 != null &&
              placeName.text.isNotEmpty &&
              description.text.isNotEmpty &&
              latitude.text.isNotEmpty &&
              longitude.text.isNotEmpty)
          ? conn.query(
              'insert into place (placeName ,  image1, image2 , image3 , description , latitude , longitude) values(?,?,?,?,?,?,?)',
              [
                  placeName.text,
                  '$_storedImage1',
                  '$_storedImage2',
                  '$_storedImage3',
                  description.text,
                  latitude.text,
                  longitude.text,
                ])
          : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Please fill all fields'),
              duration: Duration(seconds: 3),
            ));
    } on Exception catch (e) {
      print(e);
    }
    setState(() {
      isSendingData = false;
      message = const Text('Image loaded successfully');

      latitude.clear();
      longitude.clear();
      placeName.clear();
    });
  }

  String? _storedImage1;
  String? _storedImage2;
  String? _storedImage3;
  final ImagePicker picker = ImagePicker();

  void _takePhoto1() async {
    final XFile photo =
        await picker.pickImage(source: ImageSource.camera) as XFile;

    final bytes = io.File(photo.path).readAsBytesSync();

    String img64 = base64Encode(bytes);

    setState(() {
      _storedImage1 = img64;
    });
  }

  void _takePhoto2() async {
    final XFile photo =
        await picker.pickImage(source: ImageSource.camera) as XFile;

    final bytes = io.File(photo.path).readAsBytesSync();

    String img64 = base64Encode(bytes);

    setState(() {
      _storedImage2 = img64;
    });
  }

  void _takePhoto3() async {
    final XFile photo =
        await picker.pickImage(source: ImageSource.camera) as XFile;

    final bytes = io.File(photo.path).readAsBytesSync();

    String img64 = base64Encode(bytes);

    setState(() {
      _storedImage3 = img64;
    });
  }

  void _chooseImage1() async {
    final XFile photo =
        await picker.pickImage(source: ImageSource.gallery) as XFile;

    final bytes = io.File(photo.path).readAsBytesSync();

    String _img64 = base64Encode(bytes);

    setState(() {
      _storedImage1 = _img64;
    });
  }

  void _chooseImage2() async {
    final XFile photo =
        await picker.pickImage(source: ImageSource.gallery) as XFile;

    final bytes = io.File(photo.path).readAsBytesSync();

    String _img64 = base64Encode(bytes);

    setState(() {
      _storedImage2 = _img64;
    });
  }

  void _chooseImage3() async {
    final XFile photo =
        await picker.pickImage(source: ImageSource.gallery) as XFile;

    final bytes = io.File(photo.path).readAsBytesSync();

    String _img64 = base64Encode(bytes);

    setState(() {
      _storedImage3 = _img64;
    });
  }

  final placeName = TextEditingController();
  final description = TextEditingController();
  final latitude = TextEditingController();
  final longitude = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Add image'),
          actions: [
            TextButton.icon(
                onPressed: _insertImage,
                icon: const Icon(Icons.add),
                label: const Text(''))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .06,
              width: MediaQuery.of(context).size.width * .96,
              child: TextField(
                autocorrect: false,
                controller: placeName,
                decoration: const InputDecoration(
                  label: Text('placeName'),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .33,
                  child: Column(
                    children: [
                      TextButton.icon(
                          onPressed: _takePhoto1,
                          icon: const Icon(Icons.camera),
                          label: const Text('take first photo')),
                      TextButton.icon(
                          onPressed: _chooseImage1,
                          icon: const Icon(Icons.photo),
                          label: const Text('choose first photo')),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .33,
                  child: Column(
                    children: [
                      TextButton.icon(
                          onPressed: _takePhoto2,
                          icon: const Icon(Icons.camera),
                          label: const Text('take second photo')),
                      TextButton.icon(
                          onPressed: _chooseImage2,
                          icon: const Icon(Icons.photo),
                          label: const Text('choose second photo')),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .33,
                  child: Column(
                    children: [
                      TextButton.icon(
                          onPressed: _takePhoto3,
                          icon: const Icon(Icons.camera),
                          label: const Text('take third photo')),
                      TextButton.icon(
                          onPressed: _chooseImage3,
                          icon: const Icon(Icons.photo),
                          label: const Text('choose third photo')),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .15,
              width: MediaQuery.of(context).size.width * .96,
              child: TextField(
                autocorrect: false,
                controller: description,
                decoration: const InputDecoration(
                  label: Text('Describe the place'),
                ),
              ),
            ),
            Flexible(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 43,
                  child: TextField(
                    controller: latitude,
                    decoration: const InputDecoration(
                        alignLabelWithHint: true, hintText: 'latitude'),
                  ),
                ),
                SizedBox(
                  width: 43,
                  child: TextField(
                    controller: longitude,
                    decoration: const InputDecoration(
                        alignLabelWithHint: true, hintText: 'longitude'),
                  ),
                )
              ],
            )),
            ElevatedButton.icon(
                onPressed: _insertImage,
                icon: const Icon(Icons.add),
                label: const Text('insert into table')),
            SizedBox(
              height: 0.06,
              child: isSendingData
                  ? const CircularProgressIndicator()
                  : const Text('Added successfully'),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Login();
                }),
              ),
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
// TextField requires the ancestor hasSize explicitly 