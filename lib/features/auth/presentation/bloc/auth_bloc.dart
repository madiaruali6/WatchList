import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;
  final AuthRepository authRepository;

  StreamSubscription? _authSubscription;
  bool _isSigningUp = false;

  AuthBloc({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.authRepository,
  }) : super(const AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<_AuthUserChanged>(_onAuthUserChanged);

    // Следим за состоянием авторизации всё время, пока приложение открыто.
    // Это позволяет main.dart автоматически показывать нужный экран.
    _authSubscription = authRepository.authStateChanges.listen((user) {
      if (_isSigningUp) return;
      add(_AuthUserChanged(user));
    });
  }

  void _onAuthUserChanged(
    _AuthUserChanged event,
    Emitter<AuthState> emit,
  ) {
    final user = event.user;
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    _isSigningUp = true;
    try {
      await signUpUseCase(email: event.email, password: event.password);
      await signOutUseCase();
      emit(AuthRegistrationSuccess(event.email));
    } catch (e) {
      emit(AuthError(e.toString().replaceFirst('Exception: ', '')));
    } finally {
      _isSigningUp = false;
    }
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await signInUseCase(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await signOutUseCase();
    emit(const AuthUnauthenticated());
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}

class _AuthUserChanged extends AuthEvent {
  final AppUser? user;

  const _AuthUserChanged(this.user);

  @override
  List<Object?> get props => [user];
}
