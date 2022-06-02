import 'package:shared_preferences/shared_preferences.dart';

const String sessionTokenKey = 'session-token';

Future<void> saveToken(String token) async {
  var sharedPrefences = await SharedPreferences.getInstance();
  await sharedPrefences.setString(sessionTokenKey, token);
}

Future<String?> getToken() async {
  var sharedPrefences = await SharedPreferences.getInstance();
  return sharedPrefences.getString(sessionTokenKey);
}

Future<bool> removeToken() async {
  var sharedPrefences = await SharedPreferences.getInstance();
  return sharedPrefences.remove(sessionTokenKey);
}
