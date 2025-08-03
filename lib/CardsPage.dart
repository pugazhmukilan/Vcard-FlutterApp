import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:visiting_card/DB/DB_init.dart';
import 'package:visiting_card/bloc/db_bloc.dart';
import 'package:visiting_card/utils/randomImage.dart';
import 'package:visiting_card/widgets/BottomNav.dart' show BottomNavBar;

class Cardspage extends StatefulWidget {
  const Cardspage({super.key});

  @override
  State<Cardspage> createState() => _CardspageState();
}

class _CardspageState extends State<Cardspage> {
  @override
  void initState() {
    super.initState();
    // Safely add event after widget binding
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DbBloc>().add(GetAllUsers());
    });
  }
  @override
  Widget build(BuildContext context) {
    //BlocProvider.of<DbBloc>(context).add(GetAllUsers());
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
                  //TODO: Make the card better in loooks
                  
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset(getRandomAvatar(user["gender"]),scale:2, fit: BoxFit.fill),
                  ),
                  title: Text(user['name'][0].toUpperCase()+ user["name"].substring(1) ?? 'No Name',style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold),),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 210, 210, 210),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(user['profession'][0].toUpperCase()+ user["profession"].substring(1) ?? 'No Profession',),
                        )),
                      Text(user['phonenumber'] ?? 'No Phone Number'),
                      Text(user['email'] ?? 'No Email'),
                    ],
                  ),
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