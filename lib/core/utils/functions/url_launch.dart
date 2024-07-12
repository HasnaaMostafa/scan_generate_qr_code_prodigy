import 'package:url_launcher/url_launcher.dart';

Future<void> launchCustomUrl(context, String url) async {
  Uri uri = Uri.parse(url);

  if (await canLaunch(uri.toString())) {
    await launchUrl(uri);
  } else {}
}
