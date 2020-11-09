import 'package:greycells/models/token/token.dart';
import 'package:greycells/networking/serializable.dart';

class TokenSerializable implements Serializable<Token> {
  @override
  Token fromJson(Map<String, dynamic> json) {
    return Token.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Token item) {
    return item.toJson();
  }

  @override
  List<Token> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((item) => item == null ? null : fromJson(item))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<Token> items) {
    return items?.map((item) => item?.toJson())?.toList();
  }
}
