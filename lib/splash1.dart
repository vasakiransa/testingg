import 'dart:async';
import 'package:cng/detailed_screen.dart';
import 'package:cng/otp_screen.dart';
import 'package:cng/page4.dart';
import 'package:cng/wait_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Splash1 extends StatefulWidget {
  @override
  State<Splash1> createState() => _SplashState1();
}

TextEditingController textFieldController = TextEditingController();
String number = textFieldController.text;

class _SplashState1 extends State<Splash1> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';

  @override
  void initState() {
    super.initState();
    // Add any initialization logic here (if necessary)
  }

  void _validateAndNavigate(BuildContext context) {
    String phoneNumber = textFieldController.text.trim();

    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your mobile number'),
        ),
      );
    } else if (!RegExp(r'^\d{10}$').hasMatch(phoneNumber)) {
      // Check if it's a valid 10-digit number
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid 10-digit mobile number'),
        ),
      );
    } else {
      // Format phone number for Firebase (e.g., +91<PhoneNumber>)
      String formattedNumber = '+91$phoneNumber';

      // Start Firebase OTP verification
      _auth.verifyPhoneNumber(
        phoneNumber: formattedNumber, // Ensure the number is in E.164 format
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatically sign in the user after OTP verification
          await _auth.signInWithCredential(credential);
          // Navigate to OTP screen or the next screen
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => OtpScreen(
          //       text: phoneNumber,
          //       verificationId: _verificationId, // Pass the verificationId here
          //     ),
          //   ),
          // );
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle error when verification fails
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Verification failed. Please try again.'),
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          // This is called when a verification code is sent
          setState(() {
            _verificationId = verificationId; // Save verificationId for later
          });

          // Navigate to the OTP screen with the verificationId
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                text: phoneNumber,
                verificationId: verificationId,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout scenario (optional)
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(top: 500),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(14),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x40959595),
                      offset: Offset(0, -2),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(26, 20.4, 26, 18),
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _validateAndNavigate(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50),
                                child: Container(
                                  width: double.infinity,
                                  height: 59,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE47B37),
                                    borderRadius: BorderRadius.circular(29.5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Send OTP',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
