import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../../core/utils/functions/url_launch.dart';

class QrScanViewBody extends StatefulWidget {
  const QrScanViewBody({super.key});

  @override
  State<QrScanViewBody> createState() => _QrScanViewBodyState();
}

class _QrScanViewBodyState extends State<QrScanViewBody> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isScan = false;

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
      backgroundColor: const Color(0xffd14909),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "QR Scanner",
          style: TextStyle(color: Color(0xffd14909)),
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (controller != null) {
                  controller!.resumeCamera();
                }
              },
              icon: const Icon(Icons.qr_code_scanner))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: const Color(0xffd14909),
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300.0,
              ),
            ),
          ),
          if ((result != null))
            Expanded(
              flex: 1,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    onPressed: () {
                      launchCustomUrl(context, "${result!.code}").then((value) {
                        controller!.resumeCamera();
                      });
                    },
                    child: Text("${result!.code}",
                        style: const TextStyle(color: Color(0xffd14909))),
                  ),
                ),
              )
                  // : ElevatedButton(
                  //     style: ButtonStyle(
                  //         shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(20))),
                  //         backgroundColor:
                  //             WidgetStateProperty.all(Colors.white)),
                  //     onPressed: () {
                  //       setState(() {
                  //         isScan = true;
                  //       });
                  //     },
                  //     child: const Text(
                  //       'Scanning',
                  //       style: TextStyle(color: Color(0xffd14909)),
                  //     ),
                  //   ),
                  ),
            )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      controller.pauseCamera();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
