import 'package:gemini/src/authentication/data/models/user_model.dart';

abstract class RemoteDatasource {
  Future<UserModel> signupUser();
}


class RemoteDatasourceImpl implements RemoteDatasource{
  
  @override
  Future<UserModel> signupUser() {
    throw UnimplementedError();
  }

}
