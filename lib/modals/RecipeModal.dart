class RecipeModal {
  List<Results>? results;

  RecipeModal({this.results});

  RecipeModal.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }
}

class Results {
  int? id;
  String? title;
  String? image;
  int? servings;
  int? ready;

  Results({this.id, this.title, this.image, this.servings, this.ready});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
        id: json['id'],
        title: json['title'],
        image: json['image'],
        servings: json['servings'],
        ready: json['readyInMinutes']);
  }
}
