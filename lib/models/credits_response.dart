import 'dart:convert';

import 'app_models.dart';

class CreditsResponse {
  int id;
  List<Cast> cast;
  List<Cast> crew;

  CreditsResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory CreditsResponse.fromRawJson(String str) {
    final jsonData = json.decode(str);
    final castData = jsonData['cast'] as List;
    final cast = castData.map((item) => Cast.fromMap(item)).toList();

    return CreditsResponse(
      id: jsonData['id'], // Don't forget to parse the id as well
      cast: cast,
      crew: [], // You can set crew to an empty list if you don't need the crew information
    );
  }
}
