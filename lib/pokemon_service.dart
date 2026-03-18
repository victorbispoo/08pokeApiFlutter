import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/pokemon_model.dart';

class PokemonService {
  Future<Pokemon?> fetchPokemon(String pokemonName) async {
    var url = "https://pokeapi.co/api/v2/pokemon/$pokemonName";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return Pokemon.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}