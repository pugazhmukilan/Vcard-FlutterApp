
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visiting_card/bloc/db_bloc.dart';
import 'package:visiting_card/utils/randomImage.dart';


class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.user,
  });

  final Map<String, dynamic> user;

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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
    // Avatar
    Image.asset(getRandomAvatar(user["gender"]),scale: 12,), // Use your asset here
    
    const SizedBox(width: 16),
    
    // Name, Role, Contact Info
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name and Role
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                 Text(
                  user['name'][0].toUpperCase()+ user["name"].substring(1),
                  style: TextStyle(
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
                  child:  Text(
                    user['profession'][0].toUpperCase()+ user["profession"].substring(1),
                    style: TextStyle(
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
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
           Text(
            user["email"] ?? 'No Email',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    ),
    
    // Delete icon
    IconButton(
      onPressed: () {
        // handle delete
         context.read<DbBloc>().add(deleteUser(id: user['id']));
      },
      icon: const Icon(Icons.delete, color: Colors.red),
    ),
                  ],
                ));
  }
}