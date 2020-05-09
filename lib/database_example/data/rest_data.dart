import 'package:formvalidation/database_example/model/user.dart';
import 'package:formvalidation/database_example/utils/network_util.dart';

class RestData {
  NetworkUtil networkUtil = NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "";

  Future<User> login(String username, String password) async {
    return Future.value(User(username, password));
  }
}
