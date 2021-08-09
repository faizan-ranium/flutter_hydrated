import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:offline_first_app/modules/home/models/pokemon.dart';
import 'package:offline_first_app/modules/home/repositories/pokemon_repository.dart';
import 'dart:convert';

part 'pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> with HydratedMixin {
  final PokemonRepository pokemonRepository;
  final Connectivity connectivity;
  PokemonCubit(this.pokemonRepository, this.connectivity)
      : super(PokemonInitial());

  Future<void> getPokemonList() async {
    final connectivityStatus = await connectivity.checkConnectivity();
    // if (connectivityStatus == ConnectivityResult.none) {
    //   // getLocalPokemonList();
    // } else {
    getRemotePokemonList();
    // }
  }

  Future<void> getRemotePokemonList() async {
    try {
      emit(PokemonLoading());
      final result = await pokemonRepository.getAllPokemons();
      emit(PokemonLoaded(pokemonList: result));
    } catch (error) {
      emit(PokemonError());
    }
  }

  @override
  PokemonState? fromJson(Map<String, dynamic> json) {
    return PokemonLoaded.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(PokemonState state) {
    if (state is PokemonLoaded) {
      return state.toMap();
    }

    return null;
  }
}
