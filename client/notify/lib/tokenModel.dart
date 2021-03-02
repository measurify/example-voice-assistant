import 'dart:convert';

TokenModel tokenFromJson(String str) => TokenModel.fromJson(json.decode(str));

String tokenToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
  final String token;

  TokenModel({this.token});

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      TokenModel(token: json["token"]);

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
