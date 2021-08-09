import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';
import 'package:offline_first_app/modules/home/models/pokemon.dart';
import 'package:offline_first_app/modules/home/repositories/remote_pokemon_repository.dart';

part 'pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  final RemotePokemonRepository remotePokemonRepository;
  final Connectivity connectivity;
  PokemonCubit(this.remotePokemonRepository, this.connectivity)
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
      final result = await remotePokemonRepository.getAllPokemons();
      emit(PokemonLoaded(pokemonList: result));
    } catch (error) {
      emit(PokemonError());
    }
  }
}
