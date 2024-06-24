import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:giovanny_siqueiros_evaluation_app/models/character.dart';

class ApiService {
  final String baseUrl = 'https://rickandmortyapi.com/api';

  Future<List<Character>> fetchCharacters(int page) async {
    final response = await http.get(Uri.parse('$baseUrl/character/?page=$page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Character> characters = (data['results'] as List)
          .map((json) => Character.fromJson(json))
          .toList();
      return characters;
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<Character> fetchCharacter(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/character/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Character.fromJson(data);
    } else {
      throw Exception('Failed to load character');
    }
  }
}