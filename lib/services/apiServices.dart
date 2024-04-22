import 'dart:convert';

import 'package:fluttertest/modals/RecipeModal.dart';
import 'package:fluttertest/modals/recipeInfoModal.dart';

import 'package:http/http.dart' as http;

class NetworkApiServices {
  Future<List<Results>> getRecipeModal(String? searchQuery) async {
    final response = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/search?query="$searchQuery"&apiKey=5ac524cae6c64e08b0c05c9c0e7467d2'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['results'];
      List<Results> recipes =
          data.map((json) => Results.fromJson(json)).toList();
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<List<RecipeInfoModal>> getRecipeInfo(int id) async {
    final response = await http.get(Uri.parse(
        "https://api.spoonacular.com/recipes/$id/information?apiKey=5ac524cae6c64e08b0c05c9c0e7467d2"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['extendedIngredients'];
      List<RecipeInfoModal> info = List<RecipeInfoModal>.from(jsonData
          .map((ingredientJson) => RecipeInfoModal.fromJson(ingredientJson)));

      return info;
    } else {
      throw Exception("");
    }
  }
}
