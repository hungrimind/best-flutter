import 'package:demo/auth/user_service.dart';
import 'package:demo/core/database_abstraction.dart';
import 'package:demo/core/database_view_model.dart';
import 'package:demo/core/locator.dart';
import 'package:flutter/material.dart';

import '../auth/user.dart';

class DatabasePage extends StatefulWidget {
  const DatabasePage({super.key});

  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  late final DatabaseViewModel databaseViewModel = DatabaseViewModel(
    databaseAbstraction: locator<DatabaseAbstraction>(),
    userService: locator<UserService>(),
  );

  @override
  void initState() {
    super.initState();
    databaseViewModel.init();
  }

  @override
  void dispose() {
    databaseViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Database View'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder<List<int>>(
              valueListenable: databaseViewModel.sessions,
              builder: (context, sessions, _) {
                return _buildSessionsSection(theme, sessions);
              },
            ),
            const SizedBox(height: 32),
            ValueListenableBuilder<List<User>>(
              valueListenable: databaseViewModel.users,
              builder: (context, users, _) {
                return _buildUsersSection(theme, users);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionsSection(ThemeData theme, List<int> sessions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sessions',
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        if (sessions.isEmpty)
          _buildEmptyView(
            theme,
            icon: Icons.schedule_outlined,
            message: 'No sessions in database',
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return Card(
                child: ListTile(
                  title: Text(
                    'Session user_id: $session',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildUsersSection(ThemeData theme, List<User> users) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Users',
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        if (users.isEmpty)
          _buildEmptyView(
            theme,
            icon: Icons.people_outline,
            message: 'No users in database',
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.primary,
                  child: Text(
                    user.name[0].toUpperCase(),
                    style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
                title: Text(
                  user.name,
                  style: theme.textTheme.titleMedium,
                ),
                subtitle: Text(
                  'ID: ${user.id} - UID: ${user.uid}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    databaseViewModel.deleteUser(user);
                  },
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildErrorView(ThemeData theme, Object? error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Error: $error',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView(ThemeData theme, {
    required IconData icon,
    required String message,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: theme.colorScheme.secondary),
          const SizedBox(height: 16),
          Text(message, style: theme.textTheme.titleMedium),
        ],
      ),
    );
  }
}
