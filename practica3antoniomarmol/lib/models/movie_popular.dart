import 'package:movies_app/models/models.dart';

class movies_popular {
  movies_popular({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int? page;
  List<Movie> results;
  int? totalPages;
  int? totalResults;

  factory movies_popular.fromJson(String str) =>
      movies_popular.fromMap(json.decode(str));

  factory movies_popular.fromMap(Map<String, dynamic> json) => movies_popular(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
