import 'package:meta/meta.dart';
import 'package:mental_health/models/user/user.dart';
import 'package:mental_health/models/user/user_serializable.dart';
import 'package:mental_health/networking/http_service.dart';

class UserRepository {
  var _userSerializable;

  HttpService<User, UserSerializable> _userHttpService;

  UserRepository() {
    _userSerializable = UserSerializable();
    _userHttpService = HttpService(_userSerializable);
  }

  Future<User> get(int id) async {
    return _userHttpService.get("/user/$id");
  }
  
  Future<User> post(User user) async {
    return _userHttpService.post("/user", user);
  }

  Future<User> authenticate({@required String contactNumber}) async {
    return _userHttpService.get("/user?mobile_number=$contactNumber");
  }
}
