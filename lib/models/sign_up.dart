// ignore_for_file: deprecated_member_use

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import 'login.dart';
 
 class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State {
  GlobalKey<ScaffoldState> key1 = GlobalKey<ScaffoldState>();


  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password
  = TextEditingController();
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

  @override
  void initState() {
    // Services.db;
    super.initState();
    _username = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
  }

 void _addUser()async{
   var conn = await connection ;
   conn.query('insert into users(username , email , password ) values  (?,?,?) ' , [
     _username.text ,
     _email.text,
     _password.text

   ]);
 }

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'PocketPokhara',
      theme: ThemeData(
        primaryColor: Colors.green,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        key: key1,
        appBar: AppBar(
          title:const  Text('Sign Up'),
        ),
        body: Material(
          type: MaterialType.canvas,
          child: Form(
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 75.0),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: TextFormField(
                      controller: _username,
                      //autovalidate: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your desired username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.green,
                        focusColor: Colors.green,
                        border: OutlineInputBorder(
                            gapPadding: 10.2,
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:  const BorderSide(
                                color: Colors.green,
                                width: 7.0,
                                style: BorderStyle.solid)),
                        hintText: ('Username'),
                        errorStyle: const TextStyle(
                          color: Colors.orange,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  const EdgeInsets.all(7.0),
                    child: TextFormField(
                      controller: _email,
                      validator: (email){
                        if( EmailValidator.validate(email!)==true){
                          return 'the email is validated';
                        }
                        return null;
                      },
                      // autovalidate: true,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                         return ;
                        }
                     
                      
                      },

                      decoration: InputDecoration(
                        fillColor: Colors.green,
                        focusColor: Colors.green,
                        border: OutlineInputBorder(
                            gapPadding: 10.2,
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(color: Colors.green)),
                        hintText: ('Email'),
                        errorStyle:   const TextStyle(
                          color: Colors.orange,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: TextFormField(
                      controller: _password,
                      validator: ( value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      textAlign: TextAlign.left,
                      //autovalidate: true,
                      decoration: InputDecoration(
                        fillColor: Colors.green,
                        focusColor: Colors.green,
                        border: OutlineInputBorder(
                            gapPadding: 10.2,
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(color: Colors.green)),
                        hintText: ('Password'),
                        errorStyle:const  TextStyle(
                          color: Colors.orange,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),

                  //TextFormField(),
                  Center(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: () {

                        setState(() {
                          _addUser();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return Login();
                              }));
                          /*() {
                            
                          };*/
                        });
                        key1.currentState!.showSnackBar(SnackBar(
                              content: const Text('Successfully Registered !'),
                              action: SnackBarAction(
                                textColor: Colors.blue,
                                label: 'proceed to login',
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Login();
                                  }));
                                },
                              ),
                            ));
                      
                      },
                      color: Colors.green,
                      //padding:EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                      child: const Text('Register'),
                    ),
                  ),
                ]),
          ),
        ),
      ),
      color: Colors.lightGreen,
    );
  }
}