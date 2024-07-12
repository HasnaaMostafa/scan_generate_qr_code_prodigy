import "dart:io";

import "package:flutter/foundation.dart";
import "package:path_provider/path_provider.dart";
import 'package:share_plus/share_plus.dart';

Future<void> shareImage(Uint8List image) async {
  final directory = await getTemporaryDirectory();
  final imagePath = File('${directory.path}/qr_code.png');
  await imagePath.writeAsBytes(image);

  final XFile file = XFile(imagePath.path);
  Share.shareXFiles(
    [file],
  );
}
