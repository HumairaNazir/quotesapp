import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/quotes_provider.dart';
import '../widgets/app_button_widget.dart';
import 'favorite_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuotesProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Daily Quotes",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF6A1B9A),
        shadowColor: Colors.black.withOpacity(0.3),

        elevation: 6,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
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
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: theme.cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '"${provider.currentQuote!.quoteText}"',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lora(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: theme.textTheme.bodyLarge?.color,
                                ),
                              ),
                              const SizedBox(height: 20),

                              Text(
                                "- ${provider.currentQuote!.quoteAuthor}",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  color: theme.textTheme.bodySmall?.color,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Buttons Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      provider.isQuoteFavorite(
                                            provider.currentQuote!,
                                          )
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                      size: 28,
                                    ),
                                    onPressed: () {
                                      provider.toggleQuoteFavorite(
                                        provider.currentQuote!,
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 16),

                                  // Copy
                                  IconButton(
                                    icon: const Icon(Icons.copy, size: 28),
                                    onPressed: () {
                                      final quote = provider.currentQuote!;
                                      final text =
                                          "${quote.quoteText}\n- ${quote.quoteAuthor}";
                                      Clipboard.setData(
                                        ClipboardData(text: text),
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text("Copied to clipboard!"),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 16),

                                  // Share
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Button(
                    text: "Next Quote",
                    playSound: true,
                    onPressed: () {
                      provider.getRandomQuote();
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
