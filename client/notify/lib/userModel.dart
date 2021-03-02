import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.docs,
  });

  List<Doc> docs;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        docs: List<Doc>.from(json["docs"].map((x) => Doc.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
      };
}

class Doc {
  Doc({
    this.visibility,
    this.tags,
    this.relations,
    this.id,
  });

  String visibility;
  List<dynamic> tags;
  List<dynamic> relations;
  String id;

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        visibility: json["visibility"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        relations: List<dynamic>.from(json["relations"].map((x) => x)),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "visibility": visibility,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "relations": List<dynamic>.from(relations.map((x) => x)),
        "_id": id,
      };
}
