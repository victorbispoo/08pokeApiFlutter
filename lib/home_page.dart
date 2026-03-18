import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = TextEditingController();

  String image = '';
  String name = '';
  String type = '';
  String weight = '';
  String height = '';
  String id = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: Text('Pokédex'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                var pokemonName = controller.text.toLowerCase();
                var url = "https://pokeapi.co/api/v2/pokemon/$pokemonName";
                try {
                  var response = await http.get(Uri.parse(url));
                  if (response.statusCode == 200) {
                    var data = jsonDecode(response.body);
                    setState(() {
                      id = data['id'].toString();
                      name =
                          data['name'][0].toUpperCase() +
                          data['name'].substring(1);
                      weight = (data['weight'] / 10).toString();
                      height = (data['height'] / 10).toString();
                      type =
                          //
                          data['types'][0]['type']['name'][0].toUpperCase() +
                          data['types'][0]['type']['name'].substring(1);
                      image = data['sprites']['front_default'];
                    });
                  } else {
                    setState(() {
                      name = 'Pokémon não encontrado';
                      image = '';
                    });
                  }
                } catch (e) {
                  setState(() {
                    name = 'Erro na requisição';
                    image = '';
                  });
                }
              },
              child: Text('Pesquisar Pokémon'),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Card(
                child: SizedBox(
                  height: 250,
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      image.isNotEmpty
                          ? Image.network(image, width: 100, height: 100)
                          : SizedBox(height: 100),
                      Column(
                        children: [
                          Text('ID: $id'),
                          Text('Nome: $name'),
                          Text('Tipo : $type'),
                          Text('Peso: $weight kg'),
                          Text('Altura: $height m'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
