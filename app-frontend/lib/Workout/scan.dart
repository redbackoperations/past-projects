// make sure to import these packages
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:redback_mobile_app/Utils/shared_prefs_util.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanQrPage();
}

class _ScanQrPage extends State<ScanQrPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // Variables needed for the QR Scanning
  Barcode? result;
  int state = 0;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // This creates the small window where the user
          // can view the QR code being scanned
          Expanded(
            flex: 5,
            child: _buildQRView(context),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  //passing this to our root
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Back to Onboarding Screen",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQRView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 5,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        // save the qr code data
        result = scanData;
        if (result?.code != null) {
          SharedPrefsUtil.updateLastScannedBikeID(result!.code!);
          debugPrint(result!.code!);
        }
        if (state == 0) {
          //Automatically pauses scanning when a box pops up
          controller.pauseCamera();

          // return back to the onboarding screen
          Navigator.of(context).pop();
        }
        state = 1;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
