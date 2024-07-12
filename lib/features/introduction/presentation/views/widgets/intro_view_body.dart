import 'package:flutter/material.dart';
import 'package:qr_code_scanner_app/features/genertate_qr/presentation/views/qr_generator_view.dart';
import 'package:qr_code_scanner_app/features/qr_scanner/presentation/views/qr_scan_view.dart';

class IntroViewBody extends StatelessWidget {
  const IntroViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/images/qr.png"),
              ),
              const SizedBox(
                height: 35,
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        backgroundColor:
                            WidgetStateProperty.all(const Color(0xffd14909))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const QrScanView()));
                    },
                    child: const Text(
                      "SCAN QR CODE",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        backgroundColor:
                            WidgetStateProperty.all(const Color(0xffd14909))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const QrGeneratorView()));
                    },
                    child: const Text(
                      "GENERATE QR CODE",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
