import 'package:dio/dio.dart';
import 'package:offline_first_app/modules/home/models/pokemon.dart';

class PokemonRepository {
  final dio = Dio();
  static const POKEMON_API_URL =
      'https://pokeapi.co/api/v2/pokemon?limit=100&offset=200';

  Future<List<Pokemon>> getAllPokemons() async {
    late final List<Pokemon> pokemonList;
    try {
      //Try to fetch data from API
      Response response = await dio.get(POKEMON_API_URL);

      if (response.statusCode == 200) {
        final pokemons = (response.data['results'] as List);
        pokemonList =
            pokemons.map((pokemon) => Pokemon.fromJson(pokemon)).toList();
      }
    } on DioError catch (_) {
      // return data from local DB in case of DioError
      // final pokemonMap = await database.query(POKEMON_TABLE_NAME);
      // pokemonList =
      //     pokemonMap.map((pokemon) => Pokemon.fromJson(pokemon)).toList();
    }
    return pokemonList;
  }
}
