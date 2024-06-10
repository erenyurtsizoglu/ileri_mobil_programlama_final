part of 'news_cubit.dart';

class FilmsState {}

class FilmsInitial extends FilmsState {}

class FilmsLoaded extends FilmsState {
  final List<Films> myfilms;

  FilmsLoaded(this.myfilms);
}

class FilmsError extends FilmsState {
  final String message;

  FilmsError(this.message);
}

class Films {
  final String imageUrl;
  final String stars;

  Films({required this.imageUrl, required this.stars});

  factory Films.fromJson(Map<String, dynamic> json) {
    return Films(
      imageUrl: json['imageUrl'],
      stars: json['stars'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'stars': stars,
    };
  }
}
