import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

const String myAppName = 'Capital Wave';
const myApiDomain = 'lollwert.space';
const myApiToken = '3bd711a0-a7be-4fd5-962d-9e6073b7100c';
const finZag = 'lollwert.space/app/c4p1t41w4ve';

const List<String> valuteList = ['EUR', 'USD', 'GBP', 'AUD', 'USD'];
const List<String> valutePairList = [
  'EUR/USD',
  'USD/JPY',
  'AUD/USD',
  'USD/CAD',
  'USD/CHF',
  'NZD/USD',
  'EUR/JPY',
  'GBP/JPY',
  'EUR/GBP',
  'AUD/JPY',
  'EUR/AUD',
  'EUR/CHF',
  'AUD/NZD',
];
final Map<String, Widget> flags = {
  'EURUSD': Image.asset(
    'assets/images/EURUSD.png',
    width: 50,
    height: 50,
  ),
  'USDJPY': Image.asset(
    'assets/images/JPNUSD.png',
    width: 50,
  ),
  'GBPUSD': Image.asset(
    'assets/images/GBRUSD.png',
    width: 50,
  ),
  'AUDUSD': Image.asset(
    'assets/images/AUSUSD.png',
    width: 50,
  ),
  'USDCAD': Image.asset(
    'assets/images/CNDUSD.png',
    width: 50,
  )
};

void shareApp({required BuildContext context, required String text}) async {
  final box = context.findRenderObject() as RenderBox;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  IosDeviceInfo info = await deviceInfo.iosInfo;
  if (info.model.toLowerCase().contains("ipad")) {
    Share.share(text,
        subject: myAppName,
        sharePositionOrigin:
            box.localToGlobal(Offset.zero) & const Size(100, 100));
  } else {
    Share.share(text, subject: myAppName);
  }
}

void launchPolicy() async {
  final uri = Uri.parse(
      'https://docs.google.com/document/d/1WZSIgzVWfRiolqGdTCzMlWmU4SE__vOcu9EbdAOfKfI/edit');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
