import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{
  static String sharedPreferenceUserLoggedInKey="ISLOGGEDIN";
  static String sharedPreferenceUserNameKey="USERNAMEKEY";
  static String sharedPreferenceUserEmailKey="USEREMAILKEY";

// saving data to shared prefrences
  Future<void> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn) ;
  }

  Future<void> saveUserNameSharedPreference(String userName) async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, userName) ;
  }

  Future<void> saveUserEmailSharedPreference(String userEmail) async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail) ;
  }

  // getting data from shared prefrences
  Future<bool> getUserLoggedInSharedPreference() async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return  prefs.getBool(sharedPreferenceUserLoggedInKey) ;
  }

  Future<String> getUserNameSharedPreference() async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return  prefs.getString(sharedPreferenceUserNameKey) ;
  }

  Future<String> getUserEmailSharedPreference() async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return  prefs.getString(sharedPreferenceUserEmailKey) ;
  }

}