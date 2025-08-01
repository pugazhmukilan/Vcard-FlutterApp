import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:visiting_card/utils/ParseString.dart';
import 'package:visiting_card/widgets/AddUserConfirmation.dart';

class Scan extends StatelessWidget {
  const Scan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Stack(
        children: [
          // Camera + QR Code scanner
         
          MobileScanner(
              onDetect: (result) {
                List<String> parsedUserDetails = parseString(result.barcodes.first.rawValue ?? '');
                //print(result.barcodes.first.rawValue);
                //print("openiningg==================================================");
                Navigator.of(context).pop(); // Close the scanner
                AddUserConfirmation(context, parsedUserDetails);
              },
            ),
          // Overlay
          ScannerOverlay(),
          Align(
            alignment: Alignment.topCenter,
           
            child:Padding(
              padding: const EdgeInsets.only(top:40.0),
              child: Text("SCAN", style:TextStyle(fontSize:20,color:const Color.fromARGB(255, 126, 126, 126))),
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
           
            child:Padding(
              padding: const EdgeInsets.only(bottom:30.0),
              child: Text("VCARD", style:TextStyle(fontSize:20,color:const Color.fromARGB(255, 126, 126, 126))),
            )
          ),
          Align(
            alignment: Alignment.topLeft,
           
            child:Padding(
              padding: const EdgeInsets.only(left:8.0,top:30),
              child: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.close, color: Colors.white, size: 30,)),
            )
          )
           
        ],
      ),
    );
  }
}

class ScannerOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scanSize = size.width * 0.7;

    return Stack(
      children: [
        // Dimmed background with transparent scanning area
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.srcOut,
          ),
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height,
                color: Colors.black.withOpacity(0.6),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: scanSize,
                  height: scanSize,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Border for scan box
        Align(
          alignment: Alignment.center,
          child: Container(
            width: scanSize,
            height: scanSize,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}
