import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_pokemon/home_view_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = ref.read(homeViewModelPod);
      viewModel.fetchRandomPokemon(ref);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Pokémon'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _searchPokemon(ref),
              const SizedBox(height: 16),
              Expanded(child: _pokemonData(ref)),
              _randomButton(ref),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _searchPokemon(WidgetRef ref) {
  final viewModel = ref.watch(homeViewModelPod);

  return Row(
    children: [
      Expanded(
        child: TextField(
          controller: viewModel.searchController,
          onChanged: (value) {
            viewModel.updateSearchInput(value);
          },
          decoration: const InputDecoration(
            labelText: 'Enter Pokémon Name or Number',
          ),
        ),
      ),
      ElevatedButton(
        onPressed: () => viewModel.fetchPokemonText(ref),
        child: const Text('Search'),
      ),
    ],
  );
}

Widget _pokemonData(WidgetRef ref) {
  final viewModel = ref.watch(homeViewModelPod);
  final pokemon = ref.watch(viewModel.currentPokemonPod);

  if (viewModel.isLoading) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  } else if (viewModel.errorMessage.isNotEmpty) {
    return Text(
      viewModel.errorMessage,
      style: const TextStyle(color: Colors.red),
    );
  } else if (pokemon != null) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Image.network(pokemon.sprites.frontDefault)),
        const SizedBox(height: 16),
        Center(
          child: Text(
            pokemon.name,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Types: ${pokemon.types.map((types) => types.type.name).join(", ")}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          'Number(id): ${pokemon.id}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          'Height: ${pokemon.height}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          'Weight: ${pokemon.weight}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          'Abilities: ${pokemon.abilities.map((ability) => ability.ability.name).join(", ")}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
      ],
    );
  } else {
    return Container();
  }
}

Widget _randomButton(WidgetRef ref) {
  final viewModel = ref.watch(homeViewModelPod);

  return ElevatedButton(
    onPressed: () => viewModel.fetchRandomPokemon(ref),
    child: const Text('Get Random Pokémon'),
  );
}
