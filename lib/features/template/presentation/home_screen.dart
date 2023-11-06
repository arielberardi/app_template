import 'package:app_template/constants/app_sizes.dart';
import 'package:app_template/features/template/domain/user.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  final user = User.fromJson(const {
                    'name': 'Ariel',
                    'email': 'ariel.berardi95@gmail.com',
                    'uid': '123',
                  });

                  debugPrint(user.toString());
                },
                child: const Text('Create User from Json'),
              ),
              ElevatedButton(
                onPressed: () {
                  final user = User.fromJson(const {
                    'name': 'Ariel',
                    'email': 'ariel.berardi95@gmail.com',
                    'uid': '123',
                  });

                  debugPrint(user.toJson().toString());
                },
                child: const Text('User to Map'),
              ),
              ElevatedButton(
                onPressed: () {
                  const user = User(
                    name: 'Ariel',
                    email: 'ariel.berardi95@gmail.com',
                    uid: '123',
                  );

                  debugPrint(user.toString());
                },
                child: const Text('Create User'),
              ),
              ElevatedButton(
                onPressed: () {
                  const user1 = User(
                    name: 'Ariel',
                    email: 'ariel.berardi95@gmail.com',
                    uid: '123',
                  );

                  const user2 = User(
                    name: 'Ariel',
                    email: 'ariel.berardi95@gmail.com',
                    uid: '123',
                  );

                  debugPrint('Result: ${user1 == user2 ? 'Equal':'Not Equal'}');

                  const user3 = User(
                    name: 'Ariell',
                    email: 'ariel.berardi95@gmail.com',
                    uid: '123',
                  );

                  debugPrint('Result: ${user2 == user3 ? 'Equal':'Not Equal'}');
                },
                child: const Text('Compare Users'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
