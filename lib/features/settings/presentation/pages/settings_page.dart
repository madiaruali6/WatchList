import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final email = state is AuthAuthenticated ? state.user.email : null;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Аккаунт', style: AppTextStyles.heading2),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.account_circle_outlined),
                title: Text(email ?? 'Пользователь'),
                subtitle: const Text('Текущий аккаунт'),
              ),
              const Divider(height: 32),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Выйти из аккаунта'),
                onTap: () {
                  context.read<AuthBloc>().add(const SignOutRequested());
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
