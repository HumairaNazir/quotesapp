import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/quotes_loader.dart';
import '../models/quote_model.dart';

class QuotesProvider extends ChangeNotifier {
  List<QuoteModel> _quotes = [];
  QuoteModel? _currentQuote;

  List<QuoteModel> _favorites = [];

  QuoteModel? get currentQuote => _currentQuote;
  List<QuoteModel> get favorites => _favorites;

  static const String _favoritesKey = 'favorite_quotes';

  // ================= FAVORITES =================

  bool isQuoteFavorite(QuoteModel quote) {
    return _favorites.any(
      (fav) =>
          fav.quoteText == quote.quoteText &&
          fav.quoteAuthor == quote.quoteAuthor,
    );
  }

  Future<void> toggleQuoteFavorite(QuoteModel quote) async {
    if (isQuoteFavorite(quote)) {
      _favorites.removeWhere(
        (fav) =>
            fav.quoteText == quote.quoteText &&
            fav.quoteAuthor == quote.quoteAuthor,
      );
    } else {
      _favorites.add(quote);
    }

    await _saveFavorites();
    notifyListeners();
  }

  // ================= STORAGE =================

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteJsonList = _favorites
        .map((q) => jsonEncode(q.toJson()))
        .toList();
    await prefs.setStringList(_favoritesKey, favoriteJsonList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteJsonList = prefs.getStringList(_favoritesKey) ?? [];

    _favorites = favoriteJsonList
        .map((json) => QuoteModel.fromJson(jsonDecode(json)))
        .toList();

    notifyListeners();
  }

  // ================= QUOTES =================

  Future<void> loadQuotes() async {
    _quotes = await QuotesLoader.loadQuotes();
    await loadFavorites(); // 👈 load favorites on app start
    getRandomQuote();
  }

  void getRandomQuote() {
    if (_quotes.isNotEmpty) {
      final randomIndex = Random().nextInt(_quotes.length);
      _currentQuote = _quotes[randomIndex];
      notifyListeners();
    }
  }
}
