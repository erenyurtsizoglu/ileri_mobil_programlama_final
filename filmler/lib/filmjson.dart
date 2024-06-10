class Film {
  final String film;
  final String imageUrl;
  final double star;

  Film({required this.film, required this.imageUrl, required this.star});

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      film: json['film'],
      imageUrl: json['imageUrl'],
      star: json['star'].toDouble(),
    );
  }
}
