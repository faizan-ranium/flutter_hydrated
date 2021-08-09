part of 'pokemon_cubit.dart';

@immutable
abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final List<Pokemon> pokemonList;
  PokemonLoaded({required this.pokemonList});

  Map<String, dynamic> toMap() {
    return {
      'pokemonList': pokemonList.map((x) => x.toMap()).toList(),
    };
  }

  factory PokemonLoaded.fromMap(Map<String, dynamic> map) {
    return PokemonLoaded(
      pokemonList: List<Pokemon>.from(
          map['pokemonList']?.map((x) => Pokemon.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonLoaded.fromJson(String source) =>
      PokemonLoaded.fromMap(json.decode(source));
}

class PokemonError extends PokemonState {}
