import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/helper/database.dart';
import 'package:flutter_chat/helper/helperfunctions.dart';
import 'package:flutter_chat/services/auth.dart';
import 'package:flutter_chat/views/chatRoomsScreen.dart';
import 'package:flutter_chat/widgets/widget.dart';


class SignIn extends StatefulWidget {

  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

AuthMethods methods=new AuthMethods();
HelperFunctions helperFunctions=new HelperFunctions();
DatabaseMethods databaseMethods=new DatabaseMethods();

final formkey=GlobalKey<FormState>();
bool _isloading=false;
QuerySnapshot snapshotUserInfo;

TextEditingController emailEditingController=new TextEditingController();
TextEditingController passwordEditingController=new TextEditingController();

 signIn(){
   if(formkey.currentState.validate()){
     helperFunctions.saveUserEmailSharedPreference(emailEditingController.text);

    databaseMethods.getUserByUserEmail(emailEditingController.text)
    .then((value){
      snapshotUserInfo=value;
       helperFunctions.saveUserNameSharedPreference(snapshotUserInfo.documents[0].data["name"]);
    });
    
     setState(() {
       _isloading=true;
     });
    

     methods.signinWithEmailAndPassword(emailEditingController.text,passwordEditingController.text)
     .then((value){
       if(value != null){
         setState(() {
           _isloading=false;
         });
         
         helperFunctions.saveUserLoggedInSharedPreference(true);
         Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context)=> ChatRoom()
              ));
       }
     });
   }
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body:_isloading?Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) :Container(
        child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: <Widget>[
            Form(
              key: formkey,
               child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextFormField(
                    validator: (val){
                      return val.isEmpty?"Enter correct email":null;
                    },
                    controller: emailEditingController,
                    decoration: textFieldInputDecoration("Email"),
                    style: simpleTextStyle(),
                  ),
                  TextFormField(
                    validator: (val){
                      return val.isEmpty?"Enter correct password":null;
                    },
                    obscureText: true,
                    controller: passwordEditingController,
                    decoration: textFieldInputDecoration("Password"),
                    style: simpleTextStyle(),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          child: Text("Forgot Password?", style: simpleTextStyle())),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: (){
                      signIn();
                    },
                      child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          color: Colors.blue, borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "SignIn",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "SignIn with Google",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Text("Don't have account? ",
                     style: TextStyle(color:Colors.white,
                     fontSize: 16
                      ),
                     ),
                     GestureDetector(
                       onTap: (){
                         widget.toggle();
                       },
                        child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8), 
                         child: Text("SignUp",
                         style: TextStyle(color:Colors.white,
                         fontSize: 16,
                         decoration: TextDecoration.underline
                         ),
                    ),
                       ),
                     ),
                    
                   ], 
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ],
        ),
          ),
      ),
    );
  }
}
