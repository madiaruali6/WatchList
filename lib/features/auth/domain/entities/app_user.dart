import 'package:equatable/equatable.dart';

/// Чистая доменная модель пользователя — не знает про Firebase.
class AppUser extends Equatable {
  final String id;
  final String? email;
  final DateTime? joinedAt;

  const AppUser({required this.id, this.email, this.joinedAt});

  @override
  List<Object?> get props => [id, email, joinedAt];
}
