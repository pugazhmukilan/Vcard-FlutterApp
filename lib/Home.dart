import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visiting_card/bloc/db_bloc.dart';
import 'package:visiting_card/bloc/info_bloc.dart';
import 'package:visiting_card/bloc/theme_bloc.dart';
import 'package:visiting_card/utils/CreateDetails.dart';
import 'package:visiting_card/widgets/BottomNav.dart';
import 'package:qr/qr.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //call the event bloc
    BlocProvider.of<InfoBloc>(context).add(CheckInfoPresentOrNot());
    return Scaffold(
      appBar: AppBar(
        title: Text('VCARD'),
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return Switch(
                value: themeState.isDarkMode,
                onChanged: (value) {
                  // Toggle the theme
                  BlocProvider.of<ThemeBloc>(context).add(ToggleTheme());
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<InfoBloc, InfoState>(
        builder: (context, state) {
          if(state is DBmodified){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Database modified successfully!"))
            );
          }
          if(state is detailsInSufficent){
            return Center(
              child:Text("Details insufficent for QR Code generation"),
            );
          }
          if(state is detailsSufficent){
            return  FutureBuilder<String>(
                future: CreateDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  
                  if (snapshot.hasError) {
                    return Center(child: Text("Error loading details"));
                          }
                          
                          String userdetails = snapshot.data ?? "";
                          
                          final qrCode = QrCode(4, QrErrorCorrectLevel.L)
                                        ..addData(userdetails);

                          final qrimage = QrImage(qrCode);
                          return Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Center(
                              child:PrettyQrView(
                                    qrImage: qrimage,
                                    decoration: const PrettyQrDecoration(),
                                  )
                              ),
                          );
                        },
                      );
          }
          
          return Container();
        },
      ),
     

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom:30.0,left:20,right:20),
        child: BottomNavBar(),
      ), 
    );
  }
}