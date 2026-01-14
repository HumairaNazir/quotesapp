import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quotes/providers/quotes_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../providers/theme_provider.dart';
import '../screens/favorite_screen.dart';
import '../screens/privacy_policy_screen.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A1B9A), Color(0xFFE040FB)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: isDark ? Colors.grey[800] : Colors.white,
                  child: Icon(
                    Icons.format_quote,
                    size: 40,
                    color: isDark ? Colors.white : Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Quotes App",
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: "By ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "Humaira",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              "Home",
              style: GoogleFonts.lora(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context); // close drawer
            },
          ),

          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(
              "Favorites",
              style: GoogleFonts.lora(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriteScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: Text(
              "Dark Mode",
              style: GoogleFonts.lora(fontWeight: FontWeight.bold),
            ),
            trailing: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Switch(
                  value: themeProvider.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                );
              },
            ),
          ),

          ListTile(
            leading: Icon(Icons.share),
            title: Text(
              "Share App",
              style: GoogleFonts.lora(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
              Share.share(
                "Check out this amazing Quotes App by Humaira! Download it here: https://play.google.com/store/apps/details?id=com.yourapp.package",
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.star_rate),
            title: Text(
              "Rate App",
              style: GoogleFonts.lora(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
              Provider.of<QuotesProvider>(
                context,
                listen: false,
              ).launchRateApp();
            },
          ),

          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text(
              "Privacy Policy",
              style: GoogleFonts.lora(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
