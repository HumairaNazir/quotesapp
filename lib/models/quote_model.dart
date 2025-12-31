class QuoteModel {
  final String quoteText;
  final String quoteAuthor;

  QuoteModel({required this.quoteText, required this.quoteAuthor});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      quoteText: json['quoteText'] ?? '',
      quoteAuthor: json['quoteAuthor'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {'quoteText': quoteText, 'quoteAuthor': quoteAuthor};
  }
}
