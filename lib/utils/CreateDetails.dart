
import 'package:shared_preferences/shared_preferences.dart';

Future<String> CreateDetails()async{
  final prefs = await SharedPreferences.getInstance();
  String result = "";
  result = "$result${prefs.getString("name")}";
  result = "$result|${prefs.getString("profession")}";
  result = "$result|${prefs.getString("phonenumber")}";
  result = "$result|${prefs.getString("email")}";
  result = "$result|${prefs.getString("gender")}";
  return result;
}