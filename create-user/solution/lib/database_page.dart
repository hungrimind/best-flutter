import 'package:flutter/material.dart';

import 'sqlite_abstraction.dart';
import 'user.dart';

class DatabasePage extends StatefulWidget {
  const DatabasePage({super.key, required this.sqliteAbstraction});
  final SqliteAbstraction sqliteAbstraction;

  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  late Stream<List<User>> usersStream;
  @override
  void initState() {
    super.initState();
    usersStream = widget.sqliteAbstraction.listenToAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Users'),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<List<User>>(
          stream: usersStream,
          initialData: widget.sqliteAbstraction.getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${snapshot.error}',
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            final users = snapshot.data ?? [];

            if (users.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people_outline,
                        size: 64, color: theme.colorScheme.secondary),
                    const SizedBox(height: 16),
                    Text(
                      'No users in database',
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Users: ${users.length}',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
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
                          'ID: ${user.id} • UID: ${user.uid}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodySmall?.color,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () {
                            widget.sqliteAbstraction.deleteUser(user);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
