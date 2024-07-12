import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../qr_scanner/presentation/views/widgets/share_qr.dart';

class QrGeneratorViewBody extends StatefulWidget {
  const QrGeneratorViewBody({super.key});

  @override
  State<QrGeneratorViewBody> createState() => _QrGeneratorViewBodyState();
}

class _QrGeneratorViewBodyState extends State<QrGeneratorViewBody> {
  TextEditingController controller = TextEditingController();
  String? qrText;
  final ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "QR Generator",
          style: TextStyle(color: Color(0xffd14909)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                    hoverColor: Color(0xffd14909),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffd14909))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffd14909))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffd14909))),
                    hintText: 'Enter url to generate QR Code',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    backgroundColor:
                        WidgetStateProperty.all(const Color(0xffd14909))),
                onPressed: () {
                  setState(() {
                    qrText = controller.text;
                  });
                  print(qrText);
                },
                child: const Text(
                  'Generate QR',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 75,
            ),
            if (qrText != null)
              Screenshot(
                controller: screenshotController,
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Center(
                    child: QrImageView(
                      data: qrText ?? "",
                      version: QrVersions.auto,
                      size: 200.0,
                      gapless: false,
                      backgroundColor: Colors.white,
                      errorStateBuilder: (cxt, err) {
                        return const Center(
                          child: Text(
                            'Something went wrong...',
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            if (qrText != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        backgroundColor:
                            WidgetStateProperty.all(const Color(0xffd14909))),
                    onPressed: () async {
                      final image = await screenshotController.capture();
                      if (image != null) {
                        await shareImage(image);
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Share QR',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
