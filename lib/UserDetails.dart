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
   late Future<SharedPreferences> prefs;

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _desiginationController = TextEditingController();
  TextEditingController _mailController = TextEditingController();
  
  late String selectedGender;
  final List<String> genderOptions = ['Male', 'Female'];

  @override
  void initState() {
    super.initState();
    prefs = SharedPreferences.getInstance();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final sharedPrefs = await prefs;

    setState(() {
      _nameController.text = sharedPrefs.getString("name") ?? "";
      _desiginationController.text = sharedPrefs.getString("profession") ?? "";
      _phoneController.text = sharedPrefs.getString("phonenumber") ?? "";
      _mailController.text = sharedPrefs.getString("email") ?? "";
      selectedGender = sharedPrefs.getString("gender") ?? "";
    });
  }
  @override
  Widget build(BuildContext context) {
    String? selectedGender;

    final List<String> genderOptions = ['Male', 'Female'];
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
            SizedBox(height:20),

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

            SizedBox(height:20),
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
            SizedBox(height:20),

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
              SizedBox(height:20),
              DropdownButtonFormField<String>(
                    
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      labelText: "Gender",
                    ),
                    //hint: Text("Select your gender"),
                    value: selectedGender,
                    onChanged: (String? newValue)async {
                      final sharedPrefs = await prefs;
                      
                      setState(() {
                        selectedGender = newValue;
                        
                      });
                       sharedPrefs.setString("gender",selectedGender.toString());
                    },
                    items: genderOptions.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select gender.';
                      }
                      return null;
                    },
                  ),
        
            


            



          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom:30.0,left:20,right:20),
        child: BottomNavBar(),
      ), 
    );
  }
}