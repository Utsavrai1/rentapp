import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentapp/localstorage/local_storage.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  Future<void> navigate() async {
    final token = await LocalStorageService().getDataFromStorage('db_token');
    if (token == null) {
      if (context.mounted) {
        context.goNamed('LogIn');
      }
    } else {
      if (context.mounted) {
        context.goNamed('Home');
      }
    }
  }

  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Something Went Wrong'),
        ],
      ),
    );
  }
}
