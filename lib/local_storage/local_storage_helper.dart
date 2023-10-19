import 'dart:convert';

import 'package:newtest/local_storage/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String _key = 'my_data';
  static const String _keyisPreLogin = 'prelogin_status';
  static const String _keyUidUser = 'userUid';
   static const String _keyUserData = 'user_data';

  //set user data
  static Future<void> setUserData(UserData userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userDataJson = userData.toJson();
    await prefs.setString(_keyUserData, json.encode(userDataJson));
  }
  //get user data
  static Future<UserData?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userDataJson = prefs.getString(_keyUserData);
    if (userDataJson != null) {
      return UserData.fromJson(json.decode(userDataJson));
    } else {
      return null;
    }
  }
  //remove user data
   static Future<void> removeUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserData);
  }


  static Future<void> setData(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, data);
  }

  static Future<String?> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }

  //User data

  static Future<void> setUserUid(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUidUser, data);
  }

  static Future<String?> getUserUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUidUser);
  }

  //hapus User data
  static Future<void> removeUserUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUidUser);
  }

  //preLogin status

  static Future<void> setPreLogin(int data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyisPreLogin, data);
  }

  static Future<int?> getDataPrelogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyisPreLogin);
  }
}
