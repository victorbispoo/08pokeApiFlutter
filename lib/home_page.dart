import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokedex/pokemon_card.dart';
import 'package:pokedex/pokemon_model.dart';
import 'package:pokedex/pokemon_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Pokemon? pokemon;
  var service = PokemonService();
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var children = [
      SizedBox(height: 20),
      SizedBox(
        height: 100,
        width: 200,
        child: Image.network(
          'https://archives.bulbagarden.net/media/upload/4/4b/Pok%C3%A9dex_logo.png',
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10.0,
          bottom: 15,
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Escreva o nome um pokemon',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 3, 15, 100),
          foregroundColor: Colors.yellow,
        ),
        onPressed: () async {
          var result = await service.fetchPokemon(controller.text.toLowerCase());
          setState(() {
            pokemon = result;
          });
        },
        child: Text('Pesquisar Pokémon'),
      ),

      Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: PokemonCard(pokemon: pokemon),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: Text('Pokédex'),
      ),
      body: SingleChildScrollView(child: Column(children: children)),
    );
  }
}
