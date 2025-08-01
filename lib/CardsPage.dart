import 'package:flutter/material.dart';
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
       
    );
  }
}