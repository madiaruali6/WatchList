import 'package:firebase_auth/firebase_auth.dart' as fb;

/// Единственное место в проекте, которое напрямую работает с
/// package:firebase_auth. Всё остальное общается через AuthRepository.
class AuthRemoteDataSource {
  final fb.FirebaseAuth firebaseAuth;

  AuthRemoteDataSource(this.firebaseAuth);

  fb.User? get currentUser => firebaseAuth.currentUser;

  Stream<fb.User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<fb.User> signUp({
    required String email,
    required String password,
  }) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user!;
  }

  Future<fb.User> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user!;
  }

  Future<void> signOut() {
    return firebaseAuth.signOut();
  }
}
