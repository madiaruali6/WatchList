import '../entities/app_user.dart';

abstract class AuthRepository {
  /// Текущий пользователь (null, если не залогинен)
  AppUser? get currentUser;

  /// Стрим изменений состояния авторизации — пригодится, чтобы
  /// приложение само переключалось между экраном входа и главным экраном
  Stream<AppUser?> get authStateChanges;

  Future<AppUser> signUp({required String email, required String password});
  Future<AppUser> signIn({required String email, required String password});
  Future<void> signOut();
}
