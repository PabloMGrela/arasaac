import 'package:flutter/foundation.dart';
import '../models/pictogram.dart';
import '../models/category.dart' as models;
import '../services/arasaac_api_service.dart';

class PictogramProvider with ChangeNotifier {
  final ArasaacApiService _apiService = ArasaacApiService();

  List<Pictogram> _pictograms = [];
  List<models.Category> _categories = [];
  final List<Pictogram> _favorites = [];
  bool _isLoading = false;
  String? _error;
  String _currentLanguage = 'es';

  List<Pictogram> get pictograms => _pictograms;
  List<models.Category> get categories => _categories;
  List<Pictogram> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get currentLanguage => _currentLanguage;

  bool isFavorite(int pictogramId) {
    return _favorites.any((p) => p.id == pictogramId);
  }

  void toggleFavorite(Pictogram pictogram) {
    if (isFavorite(pictogram.id)) {
      _favorites.removeWhere((p) => p.id == pictogram.id);
    } else {
      _favorites.add(pictogram);
    }
    notifyListeners();
  }

  void removeFavorite(int pictogramId) {
    _favorites.removeWhere((p) => p.id == pictogramId);
    notifyListeners();
  }

  void clearFavorites() {
    _favorites.clear();
    notifyListeners();
  }

  void setLanguage(String language) {
    _currentLanguage = language;
    notifyListeners();
  }

  List<Pictogram> _filterValidPictograms(List<Pictogram> pictograms) {
    return pictograms.where((p) => p.isValid).toList();
  }

  Future<void> searchPictograms(String query) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await _apiService.searchPictograms(query, language: _currentLanguage);
      _pictograms = _filterValidPictograms(results);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _pictograms = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadPictogramsByCategory(String category) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await _apiService.getPictogramsByCategory(category, language: _currentLanguage);
      _pictograms = _filterValidPictograms(results);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _pictograms = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCategories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _categories = await _apiService.getCategories(language: _currentLanguage);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _categories = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadBestPictograms() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await _apiService.getBestPictograms(language: _currentLanguage);
      _pictograms = _filterValidPictograms(results);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _pictograms = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearPictograms() {
    _pictograms = [];
    _error = null;
    notifyListeners();
  }
}
