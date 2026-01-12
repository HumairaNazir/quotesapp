import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/quotes_provider.dart';
import '../widgets/app_button_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuotesProvider>(context);
    final favorites = provider.favorites;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 6,

        title: Text(
          "Favorite Quotes",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF6A1B9A),
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text("No favorites yet!", style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final quote = favorites[index];
                return Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Quote Text
                        Text(
                          '"${quote.quoteText}"',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lora(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Author
                        Text(
                          "- ${quote.quoteAuthor}",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Button(
                                text: "Delete",
                                icon: Icons.delete,
                                height: 45,
                                startColor: Colors.red.shade700,
                                endColor: Colors.redAccent,
                                onPressed: () {
                                  provider.toggleQuoteFavorite(quote);
                                },
                              ),
                            ),

                            const SizedBox(width: 16),

                            Expanded(
                              child: Button(
                                text: "Share",
                                icon: Icons.share,
                                height: 45,
                                startColor: Colors.deepPurple,
                                endColor: Colors.purpleAccent,
                                onPressed: () {
                                  final text =
                                      '"${quote.quoteText}"\n- ${quote.quoteAuthor}';
                                  Share.share(text);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
