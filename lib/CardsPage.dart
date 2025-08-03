import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visiting_card/bloc/db_bloc.dart';
import 'package:visiting_card/widgets/BottomNav.dart' show BottomNavBar;

class Cardspage extends StatefulWidget {
  const Cardspage({super.key});

  @override
  State<Cardspage> createState() => _CardspageState();
}

class _CardspageState extends State<Cardspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title:Center(child: Text("CARDS")),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(Icons.close, color: const Color.fromARGB(255, 0, 0, 0), size: 30,)),
      ),

      body:BlocBuilder<DbBloc, DbState>(
        builder: (context, state) {
          if(state is DBmodified){
            
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  title: Text(user['name'] ?? 'No Name'),
                  subtitle: Text(user['profession'] ?? 'No Profession'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Logic to delete user goes here
                      context.read<DbBloc>().add(deleteUser(id: user['id']));
                    },
                  ),
                );
              },
            );
          }
          return Center(
            child: Text("No users found"),
          );
        }
  
      ),
       
    );
  }
}