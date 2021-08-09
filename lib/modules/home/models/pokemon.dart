import 'dart:convert';

class Pokemon {
  final String name;
  final String url;

  Pokemon({
    required this.name,
    required this.url,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      name: map['name'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());
}
