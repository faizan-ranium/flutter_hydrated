import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first_app/modules/home/models/pokemon.dart';
import 'package:offline_first_app/modules/home/repositories/pokemon_repository.dart';
import 'package:offline_first_app/modules/home/views/cubit/pokemon_cubit.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final PokemonCubit pokemonCubit;
  late final _pokemonRepository;
  late final _connectivity;

  @override
  void initState() {
    _pokemonRepository = PokemonRepository();
    _connectivity = Connectivity();

    pokemonCubit = PokemonCubit(
      _pokemonRepository,
      _connectivity,
    );

    pokemonCubit.getPokemonList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline First App Example'),
      ),
      body: BlocConsumer<PokemonCubit, PokemonState>(
        bloc: pokemonCubit,
        listener: (context, state) {
          if (state is PokemonLoaded) {}
        },
        builder: (context, state) {
          if (state is PokemonLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is PokemonLoaded) {
            return HomePageBody(pokemonList: state.pokemonList);
          }

          if (state is PokemonLoaded) {
            return HomePageBody(pokemonList: state.pokemonList);
          }

          if (state is PokemonError) {
            return Center(
              child: Text('Error.'),
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}

class HomePageBody extends StatelessWidget {
  final List<Pokemon> pokemonList;
  const HomePageBody({
    Key? key,
    required this.pokemonList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pokemonList.length == 0) {
      return Center(child: Text('No pokemons.'));
    }
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: pokemonList.length,
            itemBuilder: (context, index) {
              final pokemon = pokemonList[index];
              return ListTile(
                title: Text(pokemon.name),
              );
            },
          )
        ],
      ),
    );
  }
}
