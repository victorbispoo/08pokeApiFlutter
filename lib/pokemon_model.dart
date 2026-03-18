class Pokemon {
  final String id;
  final String name;
  final String type;
  final String weight;
  final String height;
  final String image;

  Pokemon({
    required this.id,
    required this.name,
    required this.type,
    required this.weight,
    required this.height,
    required this.image,
  });

  factory Pokemon.fromJson(Map<String, dynamic> data) {
  return Pokemon(
    id: data['id'].toString(),
    name: data['name'],
    type: data['types'][0]['type']['name'],
    weight: (data['weight'] / 10).toString(),
    height: (data['height'] / 10).toString(),
    image: data['sprites']['front_default'],
  );
}
}