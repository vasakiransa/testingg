import 'package:flutter/material.dart';
import 'dart:async';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cng/car_registration_screen.dart';
import 'package:cng/splash1.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:cng/page4.dart' as page4;
import 'package:cng/page1.dart' as page1;
import 'package:cng/page2.dart' as page2;

import 'package:cng/page3.dart' as page3;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final _pageController = PageController(initialPage: 3);

  /// Controlle r to handle bottom nav bar and also handles initial page
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 3);

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      const page1.Page1(),
      const page2.Page2(),
      const page3.Page3(),
      privacypage(),
    ];
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              notchBottomBarController: _controller,
              color: Colors.black,
              showLabel: true,
              textOverflow: TextOverflow.visible,
              maxLine: 1,
              shadowElevation: 5,
              kBottomRadius: 28.0,
              notchColor: Colors.black87,
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: false,
              durationInMilliSeconds: 300,
              itemLabelStyle: const TextStyle(fontSize: 10),
              elevation: 1,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_outlined,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 1',
                ),
                BottomBarItem(
                  inActiveItem:
                      Icon(Icons.send_outlined, color: Colors.blueGrey),
                  activeItem: Icon(
                    Icons.send_outlined,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 2',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.map_outlined,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.map_outlined,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 3',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 4',
                ),
              ],
              onTap: (index) {
                // log('current selected index $index');
                _pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
    );
  }
}

class PrivacySection extends StatelessWidget {
  final String title;
  final String content;

  PrivacySection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            content,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class privacypage extends StatefulWidget {
  const privacypage({Key? key}) : super(key: key);

  @override
  State<privacypage> createState() => privacy();
}

class privacy extends State<privacypage> {
  // CalendarController _controller;
  // @override
  // void initState() {
  //   super.initState();
  //   _controller = CalendarController();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrivacySection(
                title: '1. Acceptance of Terms',
                content:
                    'By downloading, accessing, or using the Fuel Flux application, you agree to be bound by these terms and conditions, as well as our Privacy Policy. If you do not agree with any part of these terms, you should not use the application.',
              ),
              PrivacySection(
                title: '2. User Registration',
                content:
                    'To use certain features of the Fuel Flux application, you may need to register for an account. You agree to provide accurate, current, and complete information during the registration process and keep your account information updated.',
              ),
              PrivacySection(
                title: '3. Intellectual Property',
                content:
                    'All content, trademarks, and data on the Fuel Flux application, including but not limited to text, software, code, designs, graphics, and logos, are the property of Fuel Flux or its licensors. You may not use, copy, reproduce, or distribute any content without our prior written consent.',
              ),
              PrivacySection(
                title: '4. Service Availability',
                content:
                    'We strive to keep the Fuel Flux application operational at all times. However, we do not guarantee that the application will always be available or that it will function without errors or interruptions. We reserve the right to modify, suspend, or discontinue any part of the application at any time without notice.',
              ),
              PrivacySection(
                title: '5. Data Privacy',
                content:
                    'Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and protect your personal information.',
              ),
              PrivacySection(
                title: '6. Modification of Terms',
                content:
                    'We may update these terms and conditions from time to time. Any changes will be effective immediately upon posting the revised terms in the application. Your continued use of the application after any changes indicates your acceptance of the new terms.',
              ),
              PrivacySection(
                title: '7. User Responsibilities',
                content:
                    '- You must provide accurate and complete information when registering for our services. Any incorrect information may result in service delays or cancellations.\n- You are responsible for maintaining the confidentiality of your account login details and for all activities that occur under your account.\n- You must ensure that your vehicle is parked in a safe and accessible location for fuel delivery. Any obstacles or hazards that prevent our team from delivering fuel may lead to cancellation or additional charges.',
              ),
              PrivacySection(
                title: '8. Privacy',
                content:
                    'We are committed to protecting your privacy. Please review our Privacy Policy to understand how we collect, use, and safeguard your personal information.',
              ),
              PrivacySection(
                title: '9. Contact Us',
                content:
                    'If you have any questions about these terms and conditions, please contact us at [Your Contact Information].',
              ),
              PrivacySection(
                title: '10. Changes to Terms',
                content:
                    'Fuel Flux may update these terms and conditions from time to time. Any changes will be posted in the mobile application, and your continued use of the service after such changes constitutes acceptance of the updated terms.',
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: PrivacySection(
                  title: '11. Governing Law',
                  content:
                      'These terms and conditions are governed by the laws of [Your Jurisdiction]. Any disputes arising from these terms or your use of the application will be resolved in the courts of [Your Jurisdiction].',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
