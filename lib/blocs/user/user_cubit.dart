import 'package:bloc/bloc.dart';
import 'package:trello/database/provider.dart';
import 'package:trello/models/model.dart';
import 'package:trello/repository/repository.dart';

class UserCubit extends Cubit<UserModel?> {
  UserCubit() : super(null);

  ///On load user
  Future<UserModel?> onLoadUser() async {
    ///Fetch API via repository
    final result = await UserRepository.getUserRemote();

    ///Case API success
    if (result != null) {
      await onSaveUser(result);
      return result;
    }
  }

  ///On Load User List
  Future<List<UserModel>> onLoadUserList() async {
    return await UserRepository.getUserList();
  }

  ///Only save to state
  Future<void> onSetUser(UserModel user) async {
    emit(user);
  }

  ///On save user
  Future<void> onSaveUser(UserModel user) async {
    await UserRepository.saveUser(user: user);

    emit(user);
  }

  ///On delete user
  Future<void> onDeleteUser(UserModel user) async {
    await UserRepository.deleteUser(user);
  }

  ///On delete user
  void onClear() async {
    await DatabaseProvider.clearDatabase();
    emit(null);
  }
}
