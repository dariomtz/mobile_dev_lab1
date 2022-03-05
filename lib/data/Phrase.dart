class Phrase {
  final String author;
  final String text;

  Phrase({required this.author, required this.text});

  factory Phrase.fromJson(Map<String, dynamic> json) {
    return Phrase(author: json['a'], text: json['q']);
  }
}
