class Person {
  final String id;
  final String name;
  final int beers;

  Person({
    required this.id,
    required this.name,
    required this.beers,
  });

  Person.fromJson(Map<String, dynamic>? json, String id)
      : this(
          id: id,
          name: json?['name']! as String,
          beers: json?['beers']! as int,
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'beers': beers,
    };
  }
}
