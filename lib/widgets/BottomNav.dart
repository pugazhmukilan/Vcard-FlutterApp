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
    return  Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            runAlignment: WrapAlignment.center,
            spacing: 8.0,
            
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => Home()),
                                        (Route<dynamic> route) => false, // Remove everything before HomeScreen
                                      );
                },
                child: Text('  Home  '),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Scan()));
                },
                child: Text('Scan'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetails()));
                },
                child: Text('User Details'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Cardspage()));
                },
                child: Text('Vcards'),
              ),
            ],
          ),
      ),
    );
  }
}