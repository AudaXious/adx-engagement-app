import '../models/user.dart';

abstract class AccountRepository {
  Future<User?> getCurrentSavedUser();
  Future<dynamic> getCurrentSavedUserProfile();
}