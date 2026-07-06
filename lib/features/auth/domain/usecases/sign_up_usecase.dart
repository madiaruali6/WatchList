import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<AppUser> call({required String email, required String password}) {
    return repository.signUp(email: email, password: password);
  }
}
