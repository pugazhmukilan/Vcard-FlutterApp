import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visiting_card/widgets/BottomNav.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final prefs =  SharedPreferences.getInstance();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _desiginationController = TextEditingController();
  TextEditingController _mailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        title: Center(child: Text("User Details")),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            //TODO: name text field
            //TODO: desigination field
            //TODO : PHONENUMBER
            //TODO: EMAIL
            TextField(
              controller: _nameController,
              onChanged: (value) async {
                final sharedPrefs = await prefs;
                sharedPrefs.setString("name", value);
              },
              keyboardType:TextInputType.text,
              inputFormatters: [
                 FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z.\s]')),
              ],
              decoration:InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                prefixIcon: Icon(Icons.account_circle),

              )
            ),
            SizedBox(height:10),

            TextField(
              controller: _desiginationController,
              onChanged: (value) async {
                final sharedPrefs = await prefs;
                sharedPrefs.setString("profession", value);
              },
              keyboardType:TextInputType.text,
              inputFormatters: [
                 FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z.\s]')),
              ],
              decoration:InputDecoration(
                labelText: "Profession",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                prefixIcon: Icon(Icons.account_circle),

              )
            ),

            SizedBox(height:10),
            TextField(
                controller: _phoneController,
                onChanged: (value) async {
                final sharedPrefs = await prefs;
                sharedPrefs.setString("phonenumber", value);
              },
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  
                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  prefixIcon: Icon(Icons.phone),
                                  
                ),
              ),
            SizedBox(height:10),

            TextField(
                controller: _mailController,
                onChanged: (value) async {
                final sharedPrefs = await prefs;
                sharedPrefs.setString("email", value);
              },
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  //FilteringTextInputFormatter.digitsOnly,
                  //LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  labelText: 'Email',
                  
                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  prefixIcon: Icon(Icons.mail),
                                  
                ),
              ),
            


            



          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom:30.0),
        child: BottomNavBar(),
      ), 
    );
  }
}