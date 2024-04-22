class RecipeInfoModal {
  final int id;
  final String title;
  final int readyInMinutes;
  final int servings;
  final String sourceUrl;
  final String image;
  final String imageType;
  final Taste taste;
  final List<ExtendedIngredient> extendedIngredients;

  RecipeInfoModal({
    required this.id,
    required this.title,
    required this.readyInMinutes,
    required this.servings,
    required this.sourceUrl,
    required this.image,
    required this.imageType,
    required this.taste,
    required this.extendedIngredients,
  });

  factory RecipeInfoModal.fromJson(Map<String, dynamic> json) {
    return RecipeInfoModal(
      id: json['id'],
      title: json['title'],
      readyInMinutes: json['readyInMinutes'],
      servings: json['servings'],
      sourceUrl: json['sourceUrl'],
      image: json['image'],
      imageType: json['imageType'],
      taste: Taste.fromJson(json['taste']),
      extendedIngredients: List<ExtendedIngredient>.from(
          json['extendedIngredients']
              .map((ingredient) => ExtendedIngredient.fromJson(ingredient))),
    );
  }
}

class Taste {
  final double sweetness;
  final double saltiness;
  final double sourness;
  final double bitterness;
  final double savoriness;
  final double fattiness;
  final double spiciness;

  Taste({
    required this.sweetness,
    required this.saltiness,
    required this.sourness,
    required this.bitterness,
    required this.savoriness,
    required this.fattiness,
    required this.spiciness,
  });

  factory Taste.fromJson(Map<String, dynamic> json) {
    return Taste(
      sweetness: json['sweetness'],
      saltiness: json['saltiness'],
      sourness: json['sourness'],
      bitterness: json['bitterness'],
      savoriness: json['savoriness'],
      fattiness: json['fattiness'],
      spiciness: json['spiciness'],
    );
  }
}

class ExtendedIngredient {
  final int id;
  final String aisle;
  final String image;
  final String consistency;
  final String name;
  final String nameClean;
  final String original;
  final String originalName;
  final double amount;
  final String unit;
  final List<String> meta;
  final Measures measures;

  ExtendedIngredient({
    required this.id,
    required this.aisle,
    required this.image,
    required this.consistency,
    required this.name,
    required this.nameClean,
    required this.original,
    required this.originalName,
    required this.amount,
    required this.unit,
    required this.meta,
    required this.measures,
  });

  factory ExtendedIngredient.fromJson(Map<String, dynamic> json) {
    return ExtendedIngredient(
      id: json['id'],
      aisle: json['aisle'],
      image: json['image'],
      consistency: json['consistency'],
      name: json['name'],
      nameClean: json['nameClean'],
      original: json['original'],
      originalName: json['originalName'],
      amount: json['amount'],
      unit: json['unit'],
      meta: List<String>.from(json['meta']),
      measures: Measures.fromJson(json['measures']),
    );
  }
}

class Measures {
  final Measurement us;
  final Measurement metric;

  Measures({required this.us, required this.metric});

  factory Measures.fromJson(Map<String, dynamic> json) {
    return Measures(
      us: Measurement.fromJson(json['us']),
      metric: Measurement.fromJson(json['metric']),
    );
  }
}

class Measurement {
  final double amount;
  final String unitShort;
  final String unitLong;

  Measurement({
    required this.amount,
    required this.unitShort,
    required this.unitLong,
  });

  factory Measurement.fromJson(Map<String, dynamic> json) {
    return Measurement(
      amount: json['amount'],
      unitShort: json['unitShort'],
      unitLong: json['unitLong'],
    );
  }
}
