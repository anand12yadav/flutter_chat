import 'package:flutter/material.dart';
import 'package:flutter_chat/helper/authenticate.dart';
import 'package:flutter_chat/helper/helperfunctions.dart';
import 'package:flutter_chat/views/chatRoomsScreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn=false;

  @override
  void initState() {
    getLoggedInState();
  
    super.initState();
  }

  getLoggedInState()async{
    await HelperFunctions().getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn=value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
      ),
      home:userIsLoggedIn? ChatRoom(): Authenticate(),
    );
  }
}

