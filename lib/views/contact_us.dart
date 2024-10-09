import 'dart:js_interop';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:portflolio/globals/app_buttons.dart';

import '../globals/app_colors.dart';
import '../globals/app_text_styles.dart';
import '../globals/constants.dart';
import '../helper/helper_class.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return HelperClass(
      mobile: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildContactText(),
            Constants.sizedBox(height: 40.0),
            Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              elevation: 8,
              child: TextFormField(
                controller: _nameController,
                cursorColor: AppColors.white,
                style: AppTextStyles.normalStyle(),
                decoration: buildInputDecoration(hintText: 'Full Name'),
              ),
            ),
            Constants.sizedBox(height: 20.0),
            Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              elevation: 8,
              child: TextFormField(
                controller: _emailController,
                cursorColor: AppColors.white,
                style: AppTextStyles.normalStyle(),
                decoration: buildInputDecoration(hintText: 'Email Address'),
              ),
            ),
            Constants.sizedBox(height: 20.0),
            Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              elevation: 8,
              child: TextFormField(
                controller: _phoneController,
                cursorColor: AppColors.white,
                style: AppTextStyles.normalStyle(),
                decoration: buildInputDecoration(hintText: 'Mobile Number'),
              ),
            ),
            Constants.sizedBox(height: 20.0),
            Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              elevation: 8,
              child: TextFormField(
                controller: _subjectController,
                cursorColor: AppColors.white,
                style: AppTextStyles.normalStyle(),
                decoration: buildInputDecoration(hintText: 'Subject'),
              ),
            ),
            Constants.sizedBox(height: 20.0),
            Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              elevation: 8,
              child: TextFormField(
                controller: _messageController,
                maxLines: 15,
                cursorColor: AppColors.white,
                style: AppTextStyles.normalStyle(),
                decoration: buildInputDecoration(hintText: 'Your Message'),
              ),
            ),
            Constants.sizedBox(height: 40.0),
            AppButtons.buildMaterialButton(
                buttonName: 'Send Message', onTap: _submitForm),
            Constants.sizedBox(height: 30.0),
          ],
        ),
      ),
      tablet: buildForm(),
      desktop: buildForm(),
      paddingWidth: size.width * 0.2,
      bgColor: AppColors.bgColor,
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final String name = _nameController.text;
      final String email = _emailController.text;
      final String phone = _phoneController.text;
      final String subject = _subjectController.text;
      final String message = _messageController.text;
      sendData(name, email, phone, subject, message);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sent!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void sendData(String name, String email, String phone, String subject,
      String messageContent) async {
    String username = 'ahmed99talat@gmail.com';
    String password = 'xcme77==oive01010';
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username) // my email
      ..recipients.add(username) // my email
      ..subject = subject
      ..text =
          'Name: $name\nEmail: $email\nPhone: $phone\nMessage:\n$messageContent';

    try {
      final sendReport = await send(message, smtpServer);
      debugPrint('Message sent: $sendReport');
    } on MailerException catch (e) {
      debugPrint('Message not sent. \n$e');
    }
  }

  Column buildForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        buildContactText(),
        Constants.sizedBox(height: 40.0),
        Row(
          children: [
            Expanded(
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                elevation: 8,
                child: TextField(
                  cursorColor: AppColors.white,
                  style: AppTextStyles.normalStyle(),
                  decoration: buildInputDecoration(hintText: 'Full Name'),
                ),
              ),
            ),
            Constants.sizedBox(width: 20.0),
            Expanded(
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                elevation: 8,
                child: TextField(
                  cursorColor: AppColors.white,
                  style: AppTextStyles.normalStyle(),
                  decoration: buildInputDecoration(hintText: 'Email Address'),
                ),
              ),
            ),
          ],
        ),
        Constants.sizedBox(height: 20.0),
        Row(
          children: [
            Expanded(
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                elevation: 8,
                child: TextField(
                  cursorColor: AppColors.white,
                  style: AppTextStyles.normalStyle(),
                  decoration: buildInputDecoration(hintText: 'Mobile Number'),
                ),
              ),
            ),
            Constants.sizedBox(width: 20.0),
            Expanded(
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                elevation: 8,
                child: TextField(
                  cursorColor: AppColors.white,
                  style: AppTextStyles.normalStyle(),
                  decoration: buildInputDecoration(hintText: 'Subject'),
                ),
              ),
            ),
          ],
        ),
        Constants.sizedBox(height: 20.0),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          elevation: 8,
          child: TextField(
            maxLines: 15,
            cursorColor: AppColors.white,
            style: AppTextStyles.normalStyle(),
            decoration: buildInputDecoration(hintText: 'Your Message'),
          ),
        ),
        Constants.sizedBox(height: 40.0),
        AppButtons.buildMaterialButton(
            buttonName: 'Send Message', onTap: () {}),
        Constants.sizedBox(height: 30.0),
      ],
    );
  }

  FadeInDown buildContactText() {
    return FadeInDown(
      duration: const Duration(milliseconds: 1200),
      child: RichText(
        text: TextSpan(
          text: 'Contact ',
          style: AppTextStyles.headingStyles(fontSize: 30.0),
          children: [
            TextSpan(
              text: 'Me!',
              style: AppTextStyles.headingStyles(
                  fontSize: 30, color: AppColors.robinEdgeBlue),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration({required String hintText}) {
    return InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.comfortaaStyle(),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: AppColors.bgColor2,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 16));
  }
}
