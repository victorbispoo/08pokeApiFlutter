import 'package:flutter/material.dart';
import 'package:pokedex/pokemon_service.dart';
import 'package:pokedex/pokemon_model.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon? pokemon;
  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    if (pokemon == null) {
      return SizedBox();
    }

    return Card(
      child: SizedBox(
        height: 250,
        width: 200,
        child: Column(
          children: [
            pokemon!.image.isNotEmpty
                ? Image.network(pokemon!.image, width: 100, height: 100)
                : SizedBox(height: 100),
            Column(
              children: [
                Text('ID: ${pokemon!.id}'),
                Text('Nome: ${pokemon!.name}'),
                Text('Tipo: ${pokemon!.type}'),
                Text('Peso: ${pokemon!.weight} kg'),
                Text('Altura: ${pokemon!.height} m'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
