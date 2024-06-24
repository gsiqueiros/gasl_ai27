import 'package:flutter/material.dart';
import 'package:giovanny_siqueiros_evaluation_app/models/character.dart';
import 'package:giovanny_siqueiros_evaluation_app/services/api_service.dart';

class CharacterProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Character> _characters = [];
  List<Character> _recentlyViewed = [];
  bool _isLoading = false;
  int _currentPage = 1;

  List<Character> get characters => _characters;
  List<Character> get recentlyViewed => _recentlyViewed;
  bool get isLoading => _isLoading;

  CharacterProvider() {
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    _isLoading = true;
    notifyListeners();
    try {
      List<Character> newCharacters = await _apiService.fetchCharacters(_currentPage);
      _characters.addAll(newCharacters);
      _currentPage++;
    } catch (e) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addRecentlyViewed(Character character) {
    _recentlyViewed.removeWhere((c) => c.id == character.id);
    _recentlyViewed.insert(0, character);
    if (_recentlyViewed.length > 5) {
      _recentlyViewed.removeLast();
    }
    notifyListeners();
  }
}
