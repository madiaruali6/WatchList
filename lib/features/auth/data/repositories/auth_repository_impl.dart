import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  AppUser _mapUser(fb.User user) => AppUser(
        id: user.uid,
        email: user.email,
        joinedAt: user.metadata.creationTime,
      );

  @override
  AppUser? get currentUser {
    final user = remoteDataSource.currentUser;
    return user != null ? _mapUser(user) : null;
  }

  @override
  Stream<AppUser?> get authStateChanges {
    return remoteDataSource.authStateChanges.map(
      (user) => user != null ? _mapUser(user) : null,
    );
  }

  @override
  Future<AppUser> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signUp(
        email: email,
        password: password,
      );
      return _mapUser(user);
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    }
  }

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signIn(
        email: email,
        password: password,
      );
      return _mapUser(user);
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    }
  }

  @override
  Future<void> signOut() {
    return remoteDataSource.signOut();
  }

  /// Превращает технические коды ошибок Firebase в понятные
  /// пользователю сообщения на русском.
  String _mapFirebaseError(fb.FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Этот email уже зарегистрирован';
      case 'invalid-email':
        return 'Некорректный email';
      case 'weak-password':
        return 'Пароль слишком простой (минимум 6 символов)';
      case 'user-not-found':
        return 'Пользователь с таким email не найден';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Неверный email или пароль';
      case 'too-many-requests':
        return 'Слишком много попыток. Попробуйте позже';
      default:
        return 'Ошибка авторизации. Попробуйте ещё раз';
    }
  }
}
