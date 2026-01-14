import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Privacy Policy",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF6A1B9A),
        shadowColor: Colors.black.withOpacity(0.3),

        elevation: 6,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            '''
Privacy Policy

Your privacy is important to us. This Quotes App does not collect any personal data from users. 

We may use third-party services to display ads, which may collect anonymous information.  

By using this app, you agree to our privacy terms.  

Thank you for using Quotes App!
            ''',
            style: GoogleFonts.poppins(
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
