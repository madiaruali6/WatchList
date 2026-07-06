import 'package:equatable/equatable.dart';

/// Чистая доменная модель пользователя — не знает про Firebase.
class AppUser extends Equatable {
  final String id;
  final String? email;

  const AppUser({required this.id, this.email});

  @override
  List<Object?> get props => [id, email];
}
