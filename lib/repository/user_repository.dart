import 'package:trello/api/api.dart';
import 'package:trello/blocs/bloc.dart';
import 'package:trello/models/model.dart';

class UserRepository {
  ///Login
  static Future<UserModel?> login({
    required String username,
    required String password,
  }) async {
    final result = await Api.requestLogin({
      'username': username,
      'password': password,
    });

    ///Case API success
    if (result.success) {
      return UserModel.fromJson(result.data);
    }

    ///show message
    AppBloc.messageBloc.add(OnMessage(message: result.message));
  }

  ///Valid Token
  static Future<UserModel?> validateToken() async {
    final result = await Api.requestValidateToken();

    ///Fetch api success
    if (result.success) {
      return UserModel.fromJson(result.data);
    }

    ///show message
    AppBloc.messageBloc.add(OnMessage(message: result.message));
  }

  ///Get user remote
  static Future<UserModel?> getUserRemote() async {
    final result = await Api.requestUser();

    ///Case API success
    if (result.success) {
      return UserModel.fromJson(result.data);
    }

    ///show message
    AppBloc.messageBloc.add(OnMessage(message: result.message));
  }

  ///Save User
  static Future<void> saveUser({required UserModel user}) async {
    user.setActive(true);

    final userList = await getUserList();
    final exist = userList.where((item) => item.id == user.id).isNotEmpty;
  }

  ///Get User
  static Future<UserModel?> getUser() async {
    return null;
  }

  ///Get User List
  static Future<List<UserModel>> getUserList() async {
    return [];
  }

  ///Delete User
  static Future<void> deleteUser(UserModel user) async {}

  ///Singleton factory
  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() {
    return _instance;
  }

  UserRepository._internal();
}
