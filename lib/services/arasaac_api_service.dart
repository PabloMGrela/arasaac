import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pictogram.dart';
import '../models/category.dart';

class ArasaacApiService {
  static const String baseUrl = 'https://api.arasaac.org/api';
  static const String imageBaseUrl = 'https://static.arasaac.org';

  Future<List<Pictogram>> searchPictograms(String query, {String language = 'es'}) async {
    try {
      final url = Uri.parse('$baseUrl/pictograms/$language/search/$query');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return data.map((json) => Pictogram.fromJson(json)).toList();
      } else {
        throw Exception('Error al buscar pictogramas: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<List<Pictogram>> getPictogramsByCategory(String category, {String language = 'es'}) async {
    try {
      final url = Uri.parse('$baseUrl/pictograms/$language/search/category/$category');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return data.map((json) => Pictogram.fromJson(json)).toList();
      } else {
        throw Exception('Error al obtener pictogramas por categoría: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<Pictogram> getPictogramById(int id, {String language = 'es'}) async {
    try {
      final url = Uri.parse('$baseUrl/pictograms/$language/$id');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        return Pictogram.fromJson(data);
      } else {
        throw Exception('Error al obtener pictograma: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<List<Category>> getCategories({String language = 'es'}) async {
    try {
      final url = Uri.parse('$baseUrl/categories/$language');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        List<Category> categories = [];

        data.forEach((key, value) {
          categories.add(Category.fromJson(key, value));
        });

        return categories;
      } else {
        throw Exception('Error al obtener categorías: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<List<Pictogram>> getBestPictograms({String language = 'es'}) async {
    // El endpoint de bestsellers no funciona, usamos búsquedas comunes
    try {
      final commonWords = ['casa', 'comer', 'beber', 'dormir', 'jugar', 'feliz'];
      final allPictograms = <Pictogram>[];

      for (var word in commonWords) {
        try {
          final results = await searchPictograms(word, language: language);
          allPictograms.addAll(results.take(3));
        } catch (e) {
          // Continuar con la siguiente palabra si falla
          continue;
        }
      }

      // Eliminar duplicados basándonos en el ID
      final seen = <int>{};
      return allPictograms.where((p) => seen.add(p.id)).toList();
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  String getImageUrl(int id, {bool color = true, String? language, int size = 500}) {
    final colorParam = color ? '' : '_nocolor';
    return '$imageBaseUrl/pictograms/$id/$id${colorParam}_$size.png';
  }

  String getImageDownloadUrl(int id, {bool color = true, String? language, int size = 500}) {
    return getImageUrl(id, color: color, language: language, size: size);
  }
}
