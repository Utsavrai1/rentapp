import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentapp/localstorage/local_storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  context.pushNamed('LogIn');
                  await LocalStorageService().deleteDataFromStorage('db_token');
                },
                child: const Text('LogOut'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
