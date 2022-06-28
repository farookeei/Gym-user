import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/Kaimly.dart';
import 'package:gym_user/core/themes/gymData.dart';
import 'package:gym_user/widgets/customOutlineBtn.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScan extends StatefulWidget {
  static const routeName = "/qrScan";
  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isScanned = false;
  bool isScannFinished = false;

  markattendance() async {
    try {
      await Kaimly.server.createitem(collection: 'attendance');
      setState(() {
        isScannFinished = true;
      });
    } catch (e) {
      throw e;
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // setState(() {
      //   result = scanData;
      // });
      print("Scanned  ${scanData.code}");
      if (scanData.code == gymId) {
        setState(() {
          isScanned = true;
        });
        markattendance();
        // qrKey.currentState!.dispose();
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  Widget buildResult() => Text(
        result != null
            ? "${result!.code == gymId ? true : false}"
            : "Scan to mark your attendance",
        maxLines: 3,
        style: Theme.of(context).accentTextTheme.bodyText1,
      );

  Widget builQView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderWidth: 10,
            borderLength: 10,
            borderRadius: 10,
            cutOutSize: MediaQuery.of(context).size.width * 0.8),
      );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: isScanned
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  // color: Colors.cyan,
                  child: !isScannFinished
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset('assets/animations/scanning.json',
                                height: 160),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset('assets/animations/success2.json',
                                repeat: false, height: 160),
                            Text(
                              "Attendance marked",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            CustomOutlineButton(
                                bgColor: Theme.of(context).accentColor,
                                borderColor: Theme.of(context).primaryColor,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                label: "Go Back",
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .merge(
                                        TextStyle(fontWeight: FontWeight.w600)))
                          ],
                        ),
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    builQView(context),
                    Positioned(
                      bottom: 20,
                      child: buildResult(),
                    )
                  ],
                )),
    );
  }
}
