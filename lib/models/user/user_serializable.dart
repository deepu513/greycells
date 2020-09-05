import 'package:greycells/models/user/user.dart';
import 'package:greycells/networking/serializable.dart';

class UserSerializable implements Serializable<User> {
  @override
  User fromJson(Map<String, dynamic> json) {
    return User.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(User user) {
    return user.toJson();
  }

  @override
  List<User> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray?.map((userMap) =>
    userMap == null ? null : fromJson(userMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<User> userList) {
    return userList?.map((user) => user?.toJson())?.toList();
  }
}