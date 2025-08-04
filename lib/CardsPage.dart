import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:visiting_card/DB/DB_init.dart';
import 'package:visiting_card/bloc/db_bloc.dart';
import 'package:visiting_card/utils/randomImage.dart';
import 'package:visiting_card/widgets/BottomNav.dart' show BottomNavBar;
import 'package:visiting_card/widgets/CardContainer.dart';

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

                return CardContainer(user: user);
                
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
