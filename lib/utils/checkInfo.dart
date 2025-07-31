

import 'package:shared_preferences/shared_preferences.dart';
Future<bool> checkInfoForSharedPreferences() async {
  final infoDetails = await SharedPreferences.getInstance();
  
  String? name = infoDetails.getString("name");
  String? designation = infoDetails.getString("profession");
  String? phoneNumber = infoDetails.getString("phonenumber");
  String? email = infoDetails.getString("email");
    // print("printintg");
    //   //print every detail
    //   print(name);
    //   print(email);
    //   print(phoneNumber);
    //   print(designation);

  
  if (name != null && designation != null && phoneNumber != null && email != null) {
    return true; 
  } else {
    return false;
  }
}