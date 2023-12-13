import 'dart:convert';

class Cast {
    bool adult;
    int gender;
    int id;
    String  knownForDepartment;
    String name;
    String originalName;
    double popularity;
    String? profilePath;
    int? castId;
    String? character;
    String creditId;
    int? order;
    String ? department;
    String? job;

    Cast({
        required this.adult,
        required this.gender,
        required this.id,
        required this.knownForDepartment,
        required this.name,
        required this.originalName,
        required this.popularity,
        this.profilePath,
        this.castId,
        this.character,
        required this.creditId,
        this.order,
        this.department,
        this.job,
    });

    String get fullProfilePath {
      if (profilePath == null) {
        return 'https://i.stack.imgur.com/y9DpT.jpg';
      }

      return 'https://image.tmdb.org/t/p/w500$profilePath';
    }

    factory Cast.fromRawJson(String str) => Cast.fromJson(json.decode(str));


    factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"]!,
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: json["department"]!,
        job: json["job"],
    );

  static Cast fromMap(Map<String, dynamic> map) {
  return Cast(
    adult: map["adult"],
    gender: map["gender"],
    id: map["id"],
    knownForDepartment: map["known_for_department"],
    name: map["name"],
    originalName: map["original_name"],
    popularity: map["popularity"]?.toDouble(),
    profilePath: map["profile_path"],
    castId: map["cast_id"],
    character: map["character"],
    creditId: map["credit_id"],
    order: map["order"],
    department: map["department"],
    job: map["job"],
  );
}

}

