import 'package:flutter/material.dart';
import 'package:flutter_chat/helper/database.dart';
import 'package:flutter_chat/helper/helperfunctions.dart';
import 'package:flutter_chat/services/auth.dart';
import 'package:flutter_chat/views/chatRoomsScreen.dart';
import 'package:flutter_chat/widgets/widget.dart';

class SignUp extends StatefulWidget {
  
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  AuthMethods methods=new AuthMethods();
  DatabaseMethods databaseMethods=new DatabaseMethods();
  HelperFunctions helperFunctions=new HelperFunctions();

  final formkey=GlobalKey<FormState>();
  TextEditingController usernameEditingController=new TextEditingController();
  TextEditingController emailEditingController=new TextEditingController();
  TextEditingController passwordEditingController=new TextEditingController();

  bool _isLoading=false;
 
  signup(){
    if(formkey.currentState.validate()){

      Map<String,String> userMap={
              "name":usernameEditingController.text,
              "email":emailEditingController.text
            };
      helperFunctions.saveUserEmailSharedPreference(emailEditingController.text);
      helperFunctions.saveUserNameSharedPreference(usernameEditingController.text);
      
      setState(() {
        _isLoading=true;
      });
        methods.signupWithEmailAndPassword(emailEditingController.text,passwordEditingController.text)
        .then((value){
          if(value != null){
            setState(() {
              _isLoading=false;
            });
            
            databaseMethods.uplaodUserInfo(userMap);
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
      body:_isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
      : SingleChildScrollView (
         child: Container(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
             // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Form(
                  key: formkey,
                  child: Column(
                  //  mainAxisAlignment: MainAxisAlignment.end,
                   //  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    TextFormField(
                      validator: (val){
                        return val.isEmpty || val.length < 4 ? "Enter username of atleat 4 character":null;
                      },
                      controller: usernameEditingController,
                      decoration: textFieldInputDecoration("Username"),
                      style: simpleTextStyle(),
                    ),
                    TextFormField(
                      validator: (val){
                        return val.isEmpty ? "Enter email":null;
                      },
                      controller: emailEditingController,
                      decoration: textFieldInputDecoration("Email"),
                      style: simpleTextStyle(),
                    ),
                    TextFormField(
                      validator: (val){
                        return val.isEmpty || val.length < 6 ? "Enter password upto 6 characters":null;
                      },
                      obscureText: true,
                      controller: passwordEditingController,
                      decoration: textFieldInputDecoration("Password"),
                      style: simpleTextStyle(),
                    ),
                  ],
                )),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: (){
                    signup();
                  },
                    child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "SignUp",
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "SignUp with Google",
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
                    Text(
                      "Already have account? ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: (){
                        widget.toggle();
                      },
                        child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "SignIn",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
