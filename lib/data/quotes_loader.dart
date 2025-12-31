import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/quote_model.dart';

class QuotesLoader {
  static Future<List<QuoteModel>> loadQuotes() async {
    // Read JSON file
    final String response = await rootBundle.loadString('assets/quotes.json');

    // Decode JSON
    final data = jsonDecode(response) as List;

    // Convert each item into QuoteModel
    return data.map((quote) => QuoteModel.fromJson(quote)).toList();
  }
}
