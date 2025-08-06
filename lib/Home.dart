import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visiting_card/bloc/db_bloc.dart';
import 'package:visiting_card/bloc/info_bloc.dart';
import 'package:visiting_card/bloc/theme_bloc.dart';
import 'package:visiting_card/utils/CreateDetails.dart';
import 'package:visiting_card/widgets/BottomNav.dart';
import 'package:qr/qr.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:visiting_card/widgets/StackCover.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
  
    
    
    BlocProvider.of<InfoBloc>(context).add(CheckInfoPresentOrNot());
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: colorscheme.primary,
        
        title: Text('VCARD',style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: colorscheme.onSecondary)),
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return Switch(
                
                value: themeState.isDarkMode,
                onChanged: (value) {
                  // Toggle the theme
                  BlocProvider.of<ThemeBloc>(context).add(ToggleTheme());
                },
                materialTapTargetSize: MaterialTapTargetSize.padded, // Prevents size jumping
                inactiveThumbColor: Colors.transparent,
                activeColor: Colors.transparent,
                thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                          (states) {
                            if (states.contains(MaterialState.selected)) {
                              return const Icon(Icons.dark_mode, size: 24, color: Colors.black);
                            }
                            return const Icon(Icons.light_mode, size: 24, color: Colors.black);
                          },
                        ),
              );
            },
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 8.0),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/icons/bg.png"), // your asset path
            fit: BoxFit.cover,
          ),
      ),
        child: BlocBuilder<InfoBloc, InfoState>(
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
                            return Stack(
                              children: [
                                StackCover(colorscheme: colorscheme),
        
                                Padding(
                                  padding:  EdgeInsets.all(50.0),
                                  child: Center(
                                    child:PrettyQrView(
                                          qrImage: qrimage,
                                          decoration:  PrettyQrDecoration(
                                                      shape: PrettyQrSmoothSymbol(
                                                      color:colorscheme.tertiary,// 🎯 Change color here
                                
                                                      ),
                                                      quietZone: PrettyQrQuietZone.zero,
                                                    ),
                                        )
                                    ),
                                ),
                              ],
                            );
                          },
                        );
            }
            
            return Container();
          },
        ),
      ),
     

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom:30.0,left:20,right:20),
        child: BottomNavBar(),
      ), 
    );
  }
}
