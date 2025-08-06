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

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();

  final List<String> genderOptions = ['Male', 'Female'];
  String? selectedGender;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    prefs = SharedPreferences.getInstance();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final sharedPrefs = await prefs;

    // Debug print to confirm loading
    print("Saved name: ${sharedPrefs.getString("name")}");
    print("Saved profession: ${sharedPrefs.getString("profession")}");
    print("Saved phone: ${sharedPrefs.getString("phonenumber")}");
    print("Saved email: ${sharedPrefs.getString("email")}");
    print("Saved gender: ${sharedPrefs.getString("gender")}");

    setState(() {
      _nameController.text = sharedPrefs.getString("name") ?? "";
      _designationController.text = sharedPrefs.getString("profession") ?? "";
      _phoneController.text = sharedPrefs.getString("phonenumber") ?? "";
      _mailController.text = sharedPrefs.getString("email") ?? "";
      selectedGender = sharedPrefs.getString("gender");
      isLoading = false;
    });
  }

  InputDecoration _inputDecoration(String label, IconData icon, ColorScheme colorScheme) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: colorScheme.onSecondary),
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: colorScheme.surface.withOpacity(0.03),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: colorScheme.onSecondary, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: colorScheme.tertiary, width: 2.0),
      ),
    );
  }

  Widget _spacer() => const SizedBox(height: 20);

  // TEMP: Test button to populate SharedPreferences manually
  

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text("User Details")),
        
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              onChanged: (val) async => (await prefs).setString("name", val),
              keyboardType: TextInputType.name,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z.\s]'))],
              decoration: _inputDecoration("Name", Icons.account_circle, colorScheme),
            ),
            _spacer(),
            TextField(
              controller: _designationController,
              onChanged: (val) async => (await prefs).setString("profession", val),
              keyboardType: TextInputType.text,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z.\s]'))],
              decoration: _inputDecoration("Profession", Icons.work_outline, colorScheme),
            ),
            _spacer(),
            TextField(
              controller: _phoneController,
              onChanged: (val) async => (await prefs).setString("phonenumber", val),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: _inputDecoration("Phone Number", Icons.phone, colorScheme),
            ),
            _spacer(),
            TextField(
              controller: _mailController,
              onChanged: (val) async => (await prefs).setString("email", val),
              keyboardType: TextInputType.emailAddress,
              decoration: _inputDecoration("Email", Icons.mail_outline, colorScheme),
            ),
            _spacer(),
            DropdownButtonFormField<String>(
              value: selectedGender,
              onChanged: (String? newValue) async {
                setState(() {
                  selectedGender = newValue;
                });
                (await prefs).setString("gender", newValue!);
              },
              items: genderOptions.map((gender) {
                return DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              decoration: _inputDecoration("Gender", Icons.person, colorScheme),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 30, left: 20, right: 20),
        child: BottomNavBar(),
      ),
    );
  }
}
