// ignore_for_file: deprecated_member_use

import 'package:dbtest/image_test.dart';
import 'package:dbtest/models/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mysql1/mysql1.dart';

import 'home_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();

//throw UnimplementedError();
}

class _LoginState extends State {


 @override
  void initState() {
    super.initState();
    getData();
    email = TextEditingController();
    password = TextEditingController();
 
  }
  

  List<Map<String , dynamic>> users = [];
String? text = '';
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
        await conn.query('select email, password from users');

    for (var data in result) {
      users.add({'email': data[0], 'password': data[1]});
    }

    setState(() {
      isLoading = false;
    });
  }


void clearValues() {
  email.clear();
  password.clear();
}

  GlobalKey<ScaffoldState> key1 = GlobalKey<ScaffoldState>();
  bool _obscureText = true;
  var _hide = const Icon(Icons.visibility_off);
  var _show = const Icon(Icons.visibility);
  var _temp = const Icon(Icons.visibility_off);

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      _hide = _show;
      _show = _temp;
      _temp = _hide;
    });
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

 

  final _formKey = GlobalKey<FormState>();
   final snackBar = SnackBar(
            content: const Text('Please check your email and password combination again'),
            action: SnackBarAction(
              label: 'Retry', onPressed: (){
               
              }, 
              textColor: Colors.black26,
             ));
              


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        brightness: Brightness.light,
      ),
      home: Scaffold(
        /*appBar: AppBar(
          centerTitle: true,
          /*title: Text(
            'PocketPokhara',
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.white),
          ),*/
        ),*/

        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.lightBlue,
        body: Material(
          child: Form(
            key: _formKey,
            //autovalidate: true,
            child: ListView(
              padding: const EdgeInsets.all(15.0),
              //here we can use ListView to solve renderflex error without doing resizeToAvoidBottomInset
              /* mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,*/
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 70),
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.lightBlue,
                    size: 90.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 45.0,
                    bottom: 7.0,
                  ),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      fillColor: Colors.orangeAccent,
                      focusColor: Colors.orangeAccent,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              const BorderSide(color: Colors.orangeAccent)),
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.mail_outline),
                      suffixIcon: const IconButton(
                        onPressed: null,
                        icon: Icon(Icons.person),
                      ),
                      errorStyle: const TextStyle(
                        color: Colors.orange,
                        fontSize: 15.0,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email id';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 20.0,
                  ),

                  // isThreeLine: true,
                  child: TextFormField(
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      fillColor: Colors.orangeAccent,
                      focusColor: Colors.orangeAccent,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              const BorderSide(color: Colors.orangeAccent)),
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: _hide,
                        onPressed: _toggle,
                      ),
                      errorStyle: const TextStyle(
                        color: Colors.orange,
                        fontSize: 15.0,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }
                      if (value.length <= 7) {
                        return 'Password is too short';
                      }
                      return null;
                    },
                    controller: password,
                    onSaved: (value) {
                      password = value as TextEditingController;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: () async {
           
                          
                        if (email.text == 'karun123@gmail.com' &&
                            password.text == 'demo') {
                   
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const ImageTest();
                            }));
                          
                        } 
                        
                         else if(password.text.isEmpty || email.text.isEmpty) {
                         ScaffoldMessenger.of(context).showSnackBar(snackBar );
            
                        } 
                        else if(email.text == users[0][email] && password.text == users[0][password]){
                           Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const HomePage();
                          }));
                        }
         //
                          else {  Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const HomePage();
                          }));
                           
                          }

                      //   else {
                      //  const   SizedBox(
                      //    child:  Text('please check email and password again'),
                      //     );
                         
                      //   }
                        clearValues();

                       
 

                      },
                      /*onPressed: () {
                      setState(() {
                        if (
                        Services.login(email.text, password.text) =="Success") {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }));
                        } else {
                          return key1.currentState.showSnackBar(SnackBar(
                            content:
                                Text('please check your login information'),
                            backgroundColor: Colors.deepPurple,
                          ));
                        }
                      });
                    },*/
                      //check database
                      child: Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style:
                            GoogleFonts.robotoMono(fontStyle: FontStyle.normal),
                      ),
                      color: Colors.white10,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50, top: 10),
                        child: Text(
                          'Don\'t have an account ?',
                          style: GoogleFonts.robotoMono(),
                        ),
                      ),
                    ),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUp();
                          }));
                        },
                        child: Text(
                          'Signup',
                          style: GoogleFonts.robotoMono(
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ))
                  ],
                ),
               
              ],
           
          
           
            ),
          ),
        ),
        // decoration: myBoxDecoration(BoxDecoration))
      ),
    );
  }
}

