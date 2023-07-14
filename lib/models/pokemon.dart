class Pokemon {
  final int id;
  final String name;
  final int baseExperience;
  final int height;
  final bool isDefault;
  final int order;
  final int weight;
  final List<Ability> abilities;
  final List<PokemonForm> forms;
  final Species species;
  final Sprites sprites;
  final List<Type> types;

  Pokemon({
    required this.id,
    required this.name,
    required this.baseExperience,
    required this.height,
    required this.isDefault,
    required this.order,
    required this.weight,
    required this.abilities,
    required this.forms,
    required this.species,
    required this.sprites,
    required this.types,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      baseExperience: json['base_experience'],
      height: json['height'],
      isDefault: json['is_default'],
      order: json['order'],
      weight: json['weight'],
      abilities:
          List<Ability>.from(json['abilities'].map((x) => Ability.fromJson(x))),
      forms: List<PokemonForm>.from(
          json['forms'].map((x) => PokemonForm.fromJson(x))),
      species: Species.fromJson(json['species']),
      sprites: Sprites.fromJson(json['sprites']),
      types: List<Type>.from(json['types'].map((x) => Type.fromJson(x))),
    );
  }
}

class Sprites {
  final String frontDefault;

  Sprites({
    required this.frontDefault,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(
      frontDefault: json['front_default'],
    );
  }
}

class Ability {
  final bool isHidden;
  final int slot;
  final AbilityDetails ability;

  Ability({
    required this.isHidden,
    required this.slot,
    required this.ability,
  });

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      isHidden: json['is_hidden'],
      slot: json['slot'],
      ability: AbilityDetails.fromJson(json['ability']),
    );
  }
}

class AbilityDetails {
  final String name;
  final String url;

  AbilityDetails({
    required this.name,
    required this.url,
  });

  factory AbilityDetails.fromJson(Map<String, dynamic> json) {
    return AbilityDetails(
      name: json['name'],
      url: json['url'],
    );
  }
}

class PokemonForm {
  final String name;
  final String url;

  PokemonForm({
    required this.name,
    required this.url,
  });

  factory PokemonForm.fromJson(Map<String, dynamic> json) {
    return PokemonForm(
      name: json['name'],
      url: json['url'],
    );
  }
}

class Species {
  final String name;
  final String url;

  Species({
    required this.name,
    required this.url,
  });

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
      name: json['name'],
      url: json['url'],
    );
  }
}

class Type {
  final int slot;
  final TypeDetails type;

  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      slot: json['slot'],
      type: TypeDetails.fromJson(json['type']),
    );
  }
}

class TypeDetails {
  final String name;
  final String url;

  TypeDetails({
    required this.name,
    required this.url,
  });

  factory TypeDetails.fromJson(Map<String, dynamic> json) {
    return TypeDetails(
      name: json['name'],
      url: json['url'],
    );
  }
}
