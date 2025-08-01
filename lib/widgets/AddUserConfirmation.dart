import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visiting_card/bloc/db_bloc.dart';
import 'package:visiting_card/bloc/info_bloc.dart' show InfoBloc;

void AddUserConfirmation(BuildContext context, List<String> userDetails){
  showDialog(
    context: context,
   builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Add User Confirmation"),
        content: Text("Do you want to add the following user?\n\n${userDetails.join('\n')}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              // Logic to add user goes here
              context.read<DbBloc>().add(insertUser(name:userDetails[0], profession: userDetails[1], phonenumber: userDetails[2], email: userDetails[3],gender:userDetails[4]));
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Add User"),
          ),
        ],
      );
    },
  );
}