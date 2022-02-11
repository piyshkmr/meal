import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meal/constants/styles.dart';
import 'package:flutter/material.dart';

class MealAPI {
  final String _categoryURL =
      "https://www.themealdb.com/api/json/v1/1/categories.php";
  final String _mealsListURL =
      "https://www.themealdb.com/api/json/v1/1/filter.php?c=";
  final String _mealDetailURL =
      "https://www.themealdb.com/api/json/v1/1/lookup.php?i=";

  Future<dynamic> getMealCategories() async {
    try {
      final response = await http.get(Uri.parse(_categoryURL));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["categories"];
      }
    } catch (e) {
      return [];
    }
  }

  Future<dynamic> getMealsList(String categoryName) async {
    try {
      final response = await http.get(Uri.parse(_mealsListURL + categoryName));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["meals"];
      }
    } catch (e) {
      return [];
    }
  }

  Future<dynamic> getMealYoutube(String mealId) async {
    try {
      final response = await http.get(Uri.parse(_mealDetailURL + mealId));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["meals"][0]["strYoutube"];
      }
    } catch (e) {
      return "";
    }
  }

  Future<dynamic> getMealInstructions(String mealId) async {
    try {
      final response = await http.get(Uri.parse(_mealDetailURL + mealId));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["meals"][0]["strInstructions"];
      }
    } catch (e) {
      return "";
    }
  }

  Future<dynamic> getMealIngredients(String mealId) async {
    try {
      final response = await http.get(Uri.parse(_mealDetailURL + mealId));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final meal = data["meals"][0];

        String ingredients = "";

        for (int i = 1; i <= 20; i++) {
          if (meal['strIngredient$i'] != "") {
            ingredients +=
                "$i. ${meal['strIngredient$i']} ${meal['strMeasure$i']}\n";
          }
        }

        return ingredients;
      }
    } catch (e) {
      return "";
    }
  }
}
