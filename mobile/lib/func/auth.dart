import 'dart:convert';

import 'package:popov_chat/model/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String authStorageKey = 'session-token';

Future<void> saveAuth(AuthStorage auth) async {
  var sharedPrefences = await SharedPreferences.getInstance();
  await sharedPrefences.setString(authStorageKey, json.encode(auth.toMap()));
}

Future<AuthStorage?> getAuth() async {
  var sharedPrefences = await SharedPreferences.getInstance();
  var stringifiedAuthStorage = sharedPrefences.getString(authStorageKey);
  if (stringifiedAuthStorage != null) {
    return AuthStorage.fromMap(json.decode(stringifiedAuthStorage));
  } else {
    return null;
  }
}

Future<bool> removeAuth() async {
  var sharedPrefences = await SharedPreferences.getInstance();
  return sharedPrefences.remove(authStorageKey);
}
