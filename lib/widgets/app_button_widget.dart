import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:audioplayers/audioplayers.dart';

class Button extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color startColor;
  final Color endColor;
  final bool playSound;
  final double height;

  final AudioPlayer _player = AudioPlayer();

  Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.startColor = const Color(0xFF6A1B9A),
    this.endColor = const Color(0xFFE040FB),
    this.playSound = false,
    this.height = 55,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor, endColor]),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        onPressed: () async {
          if (playSound) {
            await _player.play(AssetSource("sounds/ui_tap.mp3"));
          }
          onPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
