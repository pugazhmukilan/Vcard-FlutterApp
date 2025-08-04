import 'package:flutter/material.dart';
import 'package:visiting_card/CardsPage.dart';
import 'package:visiting_card/Home.dart';
import 'package:visiting_card/Scan.dart';
import 'package:visiting_card/UserDetails.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return  Container(
      height: 90,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(30),
        
        //border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Wrap(
            alignment: WrapAlignment.spaceAround,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.0,
            
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => Home()),
                                        (Route<dynamic> route) => false, // Remove everything before HomeScreen
                                      );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color:  Color.fromARGB(255, 131, 214, 255),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical:15),
                    child: Text('Home',style:TextStyle(color:Colors.black,fontSize: 20),),
                  )),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Scan()));
                },
                child:Image.asset("assets/icons/scan.png",color:colorScheme.secondary,scale: 3,),
              ),
              GestureDetector(
                onTap: () {
                  
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Cardspage()));
                },
                child: Image.asset("assets/icons/dict.png",color:colorScheme.secondary,scale: 3,),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetails()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset("assets/icons/add.png",color:colorScheme.secondary,scale: 3,),
                )
              ),
            ],
          ),
      ),
    );
  }
}