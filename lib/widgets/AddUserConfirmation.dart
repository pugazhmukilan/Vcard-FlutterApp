import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visiting_card/bloc/db_bloc.dart';
import 'package:visiting_card/bloc/info_bloc.dart' show InfoBloc;
import 'package:visiting_card/utils/randomImage.dart';



void AddUserConfirmation(BuildContext context, List<String> userDetails) {
  final colorScheme = Theme.of(context).colorScheme;
  final Map<String, dynamic> userMap = {
    "name": userDetails[0],
    "profession": userDetails[1],
    "phonenumber": userDetails[2],
    "email": userDetails[3],
    "gender": userDetails[4],
  };

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: colorScheme.primary,
        title:  Text("Add User Confirmation",style:TextStyle(color:colorScheme.secondary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            const SizedBox(height: 10),
            CardPreviewContainer(user: userMap),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child:  Text("Cancel",style:TextStyle(color: colorScheme.secondary)),
          ),
          Container(
            decoration: BoxDecoration(
              color:Colors.green[500],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 12),
              child: GestureDetector(
                onTap: () {
                  context.read<DbBloc>().add(insertUser(
                        name: userDetails[0],
                        profession: userDetails[1],
                        phonenumber: userDetails[2],
                        email: userDetails[3],
                        gender: userDetails[4],
                      ));
                  Navigator.of(context).pop(); // Close the current dialog
              
                  // Show success tick animation
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.of(context).pop(); // Auto-close tick dialog
                      });
                      return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.check_circle, color: Colors.green, size: 60),
                            SizedBox(height: 10),
                            Text("User Added Successfully!"),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text("Add User",style: TextStyle(color:colorScheme.primary ),),
              ),
            ),
          ),
        ],
      );
    },
  );
}


class CardPreviewContainer extends StatelessWidget {
  const CardPreviewContainer({
    super.key,
    required this.user,
  });

  final Map<String, dynamic> user;

  String _truncateEmail(String email, {int maxLength = 20}) {
    if (email.length <= maxLength) {
      return email;
    }
    
    // If it's an email, try to keep the domain part
    if (email.contains('@')) {
      List<String> parts = email.split('@');
      String localPart = parts[0];
      String domainPart = parts[1];
      
      // Calculate available space for local part
      int domainLength = domainPart.length + 1; // +1 for @
      int availableForLocal = maxLength - domainLength - 3; // -3 for "..."
      
      if (availableForLocal > 0 && localPart.length > availableForLocal) {
        return '${localPart.substring(0, availableForLocal)}...@$domainPart';
      }
    }
    
    // Fallback: simple truncation
    return '${email.substring(0, maxLength - 3)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 250, 250, 250),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100, width: 2),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(getRandomAvatar(user["gender"]), scale: 12),
          const SizedBox(width: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal  ,
            
            child: Row(
              children: [
                Text(
                  user['name'][0].toUpperCase() + user["name"].substring(1),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    user['profession'][0].toUpperCase() + user["profession"].substring(1),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            user['phonenumber'] ?? 'No Phone Number',
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Text(
            _truncateEmail(user["email"] ?? 'No Email'),
            style: const TextStyle(fontSize: 14, color: Colors.black87),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
