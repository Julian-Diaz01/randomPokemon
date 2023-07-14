import 'dart:math';
import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/pokemon.dart';

final pokeApiServicePod = FutureProvider((ref) async {
  return PokeApiService();
});

class PokeApiService {
  static const String baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  final Dio _dio = Dio();

  Future<Pokemon> fetchPokemon(String query) async {
    try {
      final response =
          await _dio.get('https://pokeapi.co/api/v2/pokemon/$query');
      final data = response.data;
      final pokemon = Pokemon.fromJson(data);
      return pokemon;
    } catch (error) {
      dev.log(error.toString());
      throw 'Failed to fetch Pokémon: $error';
    }
  }

  Future<Pokemon> fetchRandomPokemon() async {
    try {
      final randomId =
          Random().nextInt(898) + 1; // Generate random Pokemon ID from 1 to 898
      final response =
          await _dio.get('https://pokeapi.co/api/v2/pokemon/$randomId');
      final data = response.data;
      final pokemon = Pokemon.fromJson(data);
      return pokemon;
    } catch (error) {
      throw 'Failed to fetch random Pokémon: $error';
    }
  }
}
