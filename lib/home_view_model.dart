import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_pokemon/poke_api_service.dart';
import 'models/pokemon.dart';

final homeViewModelPod = Provider((ref) => HomeViewModel());

class HomeViewModel {
  final TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';
  //Pokemon? currentPokemon;
  final currentPokemonPod = StateProvider<Pokemon?>((ref) => null);

  Future<void> fetchPokemonText(ref) async {
    final pokeService = await ref.watch(pokeApiServicePod.future);

    final input = searchController.text.trim();
    if (input.isEmpty) return;

    try {
      isLoading = true;
      errorMessage = '';

      final pokemon = await pokeService.fetchPokemon(input);
      if (pokemon != null) {
        ref.read(currentPokemonPod.notifier).state = pokemon;
        errorMessage = '';
      } else {
        ref.read(currentPokemonPod.notifier).state = null;
        errorMessage = 'Pokémon not found';
      }
    } catch (error) {
      ref.read(currentPokemonPod.notifier).state = null;
      errorMessage = 'Error: $error';
    } finally {
      isLoading = false;
    }
  }

  Future<void> fetchRandomPokemon(ref) async {
    final pokeService = await ref.watch(pokeApiServicePod.future);
    try {
      isLoading = true;
      errorMessage = '';

      final pokemon = await pokeService.fetchRandomPokemon();
      ref.read(currentPokemonPod.notifier).state = pokemon;
      errorMessage = '';
    } catch (error) {
      ref.read(currentPokemonPod.notifier).state = null;
      errorMessage = 'Error: $error';
    } finally {
      isLoading = false;
    }
  }

  void updateSearchInput(String value) {
    errorMessage = '';
  }
}
