

  import 'package:url_launcher/url_launcher.dart';

Future<void> launchLink(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
    } else {
      throw 'Could not launch $url';
    }
  }
