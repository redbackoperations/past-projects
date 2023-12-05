import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Shared Preferences
class SharedPrefsUtil {
  static SharedPreferences? instance;

  // keys
  static const String lastScannedBikeIDKey = "last_scanned_bike_id";
  static const String workoutTypeKey = "workout_type";

  // init method
  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  // helper methods to get/set prefs values
  static String getRequiredValue(String key) {
    return instance!.getString(key)!;
  }

  static String? getLastScannedBikeId() =>
      instance?.getString(lastScannedBikeIDKey);

  static void updateLastScannedBikeID(String newVal) {
    // the QR Code text is stored as a JSON string, decode it and save the bikeId to shared prefs
    var decoded = json.decode(newVal);
    if (decoded['bikeId'] != null) {
      debugPrint("Updated shared prefs BikeID with value ${decoded['bikeId']}");
      instance?.setString(lastScannedBikeIDKey, decoded['bikeId']);
    }
  }

  static String? getWorkoutType() => instance?.getString(workoutTypeKey);

  static void updateWorkoutType(String newVal) {
    instance?.setString(workoutTypeKey, newVal);
  }

  static void setUserDetails(dynamic userValues) {
    instance?.setString("_id", userValues["_id"]);
    instance?.setString("username", userValues["username"]);
    instance?.setString("firstname", userValues["firstname"]);
    instance?.setString("lastname", userValues["lastname"]);
    instance?.setString("email", userValues["email"]);
    instance?.setString("password", userValues["password"]);
    instance?.setInt("redbackCoins", userValues["redbackCoins"]);
    instance?.setInt("telephone", userValues["telephone"]);
    instance?.setInt("userLevel", userValues["userLevel"]);
  }

  static void setTokens(dynamic values) {
    instance?.setString("accessToken", values["accessToken"]);
    instance?.setString("refreshToken", values["refreshToken"]);
  }
}
