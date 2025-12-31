import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quotes_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuotesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Quotes"), centerTitle: true),
      body: provider.favorites.isEmpty
          ? const Center(
              child: Text(
                "No favorite quotes yet ❤️",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                final quote = provider.favorites[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(
                      quote.quoteText,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text("- ${quote.quoteAuthor}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        provider.toggleQuoteFavorite(quote);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
