import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/quotes_provider.dart';
import 'favorite_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes App"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoriteScreen()),
              );
            },
          ),
        ],
      ),
      body: provider.currentQuote == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.currentQuote!.quoteText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "- ${provider.currentQuote!.quoteAuthor}",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ❤️ Favorite
                      IconButton(
                        icon: Icon(
                          provider.isQuoteFavorite(provider.currentQuote!)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () {
                          provider.toggleQuoteFavorite(provider.currentQuote!);
                        },
                      ),

                      const SizedBox(width: 20),

                      // 📋 Copy
                      IconButton(
                        icon: const Icon(Icons.copy, size: 28),
                        onPressed: () {
                          final quote = provider.currentQuote!;
                          final text =
                              "${quote.quoteText}\n- ${quote.quoteAuthor}";

                          Clipboard.setData(ClipboardData(text: text));

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Copied to clipboard!"),
                            ),
                          );
                        },
                      ),

                      const SizedBox(width: 20),

                      // ↗️ Share
                      IconButton(
                        icon: const Icon(Icons.share, size: 28),
                        onPressed: () {
                          final quote = provider.currentQuote!;
                          final text =
                              "${quote.quoteText}\n- ${quote.quoteAuthor}";
                          Share.share(text);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: provider.getRandomQuote,
                    child: const Text("Next Quote"),
                  ),
                ],
              ),
            ),
    );
  }
}
