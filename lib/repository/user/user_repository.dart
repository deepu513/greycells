import 'package:mental_health/models/login/login_request.dart';
import 'package:meta/meta.dart';
import 'package:mental_health/networking/http_service.dart';

class UserRepository {
  var _userSerializable;

  //HttpService<User, UserSerializable> _userHttpService;

  UserRepository() {
    //_userSerializable = UserSerializable();
    //_userHttpService = HttpService(_userSerializable);
  }

//  Future<User> get(int id) async {
//    return _userHttpService.get("/user/$id");
//  }
//
//  Future<User> post(User user) async {
//    return _userHttpService.post("/user", user);
//  }
//
//  Future<User> authenticate({@required LoginRequest loginRequest}) async {
//    return _userHttpService.get("/user?mobile_number=$loginRequest");
//  }
}
