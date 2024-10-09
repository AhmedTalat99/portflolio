import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:portflolio/globals/app_assets.dart';
import 'package:portflolio/globals/app_buttons.dart';
import 'package:portflolio/globals/app_text_styles.dart';
import 'package:portflolio/globals/constants.dart';
import 'package:portflolio/helper/helper_class.dart';
import 'package:portflolio/widgets/profile_animation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' as io;
import 'package:flutter/foundation.dart'; // for kIsWeb

import '../globals/app_colors.dart';
import '../globals/launch_link.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final socialButtons = <String>[
    AppAssets.linkedIn,
    AppAssets.github,
    AppAssets.whatsApp,
  ];
  var socialBI;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return HelperClass(
      mobile: Column(
        children: [
          buildHomePersonalInfo(size),
          Constants.sizedBox(height: 25.0),
          const ProfileAnimation()
        ],
      ),
      tablet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: buildHomePersonalInfo(size)),
          const ProfileAnimation(),
        ],
      ),
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: buildHomePersonalInfo(size)),
          const ProfileAnimation(),
        ],
      ),
      paddingWidth: size.width * 0.1,
      bgColor: Colors.transparent,
    );
  }

  Column buildHomePersonalInfo(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeInDown(
          duration: const Duration(milliseconds: 1200),
          child: Text(
            'Hello, It\'s Me',
            style: AppTextStyles.montserratStyle(color: Colors.white),
          ),
        ),
        Constants.sizedBox(height: 15.0),
        FadeInRight(
          duration: const Duration(milliseconds: 1400),
          child: Text(
            'Ahmed Talat Mohamed',
            style: AppTextStyles.headingStyles(),
          ),
        ),
        Constants.sizedBox(height: 15.0),
        FadeInLeft(
          duration: const Duration(milliseconds: 1400),
          child: Row(
            children: [
              Text(
                'And I\'m a ',
                style: AppTextStyles.montserratStyle(color: Colors.white),
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'Flutter Developer',
                    textStyle:
                        AppTextStyles.montserratStyle(color: Colors.lightBlue),
                  ),
                ],
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              )
            ],
          ),
        ),
        Constants.sizedBox(height: 22.0),
        FadeInUp(
          duration: const Duration(milliseconds: 1600),
          child: SizedBox(
            height: 48,
            child: ListView.separated(
              itemCount: socialButtons.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, child) =>
                  Constants.sizedBox(width: 8.0),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (socialBI == 0) {
                      // LinkedIn
                      launchLink('https://bit.ly/3SJTFdc');
                    } else if (socialBI == 1) {
                      launchLink('https://github.com/AhmedTalat99');
                    } else if (socialBI == 2) {
                      // whatsApp
                      launchLink('https://wa.me/201142488571');
                    }
                  },
                  onHover: (value) {
                    setState(() {
                      if (value) {
                        socialBI = index;
                      } else {
                        socialBI = null;
                      }
                    });
                  },
                  borderRadius: BorderRadius.circular(550.0),
                  hoverColor: AppColors.themeColor,
                  splashColor: AppColors.lawGreen,
                  child: buildSocialButton(
                      asset: socialButtons[index],
                      hover: socialBI == index ? true : false),
                );
              },
            ),
          ),
        ),
        Constants.sizedBox(height: 18.0),
        FadeInUp(
          duration: const Duration(milliseconds: 1800),
          child: AppButtons.buildMaterialButton(
              onTap: () async {
                await downloadCV();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'CV downloaded successfully!',
                    ),
                  ),
                );
              },
              buttonName: 'Download CV'),
        ),
      ],
    );
  }

   Future<void> contactWhatsApp() async {
    const String whatsAppUrl = 'whatsapp://send?phone=+201142488571';

    if (await canLaunchUrl(Uri.parse(whatsAppUrl))) {
      await launchUrl(Uri.parse(whatsAppUrl), webOnlyWindowName: '_blank');
    } else {
      // Handle error: WhatsApp not installed or URL can't be launched
      print("Could not launch WhatsApp");
    }
  }



  Future<void> requestPermission() async {
    if (await Permission.storage.request().isGranted) {
      // Permission granted
    }
  }

/*   Future<void> downloadCV() async {
    final Dio dio = Dio();
    try {
      // Request storage permission (Android only)
      if (Platform.isAndroid) {
        await requestPermission();
      }

      // Get the app's document directory
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/cv.pdf';

      // Download the PDF
      await dio.download(
        'https://bit.ly/3SPBF11', // URL of the CV PDF
        filePath,
      );

      // Notify the user
      print('Downloaded to $filePath');
    } catch (e) {
      print('Error: $e');
    }
  } */

  Future<void> downloadCV() async {
  final Dio dio = Dio();

  try {
    if (kIsWeb) {
      // Handle web download
      const url = 'https://bit.ly/3SPBF11';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } else if (io.Platform.isAndroid || io.Platform.isIOS) {
      // Request storage permission (Android only)
      if (io.Platform.isAndroid) {
        await requestPermission();
      }

      // Get the app's document directory
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/cv.pdf';

      // Download the PDF
      await dio.download(
        'https://bit.ly/3SPBF11', // URL of the CV PDF
        filePath,
      );

      // Notify the user
      print('Downloaded to $filePath');
    } else {
      throw 'Unsupported platform';
    }
  } catch (e) {
    print('Error: $e');
  }
}

  Ink buildSocialButton({required String asset, required bool hover}) {
    return Ink(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.themeColor, width: 2.0),
        color: AppColors.bgColor,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(6),
      child: Image.asset(
        asset,
        width: 10,
        height: 12,
        color: hover ? AppColors.bgColor : AppColors.themeColor,
        // fit: BoxFit.fill,
      ),
    );
  }
}
