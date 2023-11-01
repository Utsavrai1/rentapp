import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentapp/authentication/login_screen.dart';
import 'package:rentapp/authentication/otp_screen.dart';
import 'package:rentapp/authentication/password_screen.dart';
import 'package:rentapp/authentication/signup_screen.dart';
import 'package:rentapp/error/error_screen.dart';
import 'package:rentapp/home/home_screen.dart';
import 'package:rentapp/localstorage/local_storage.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerConfiguration = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  redirect: (value, state) async {
    final token = await LocalStorageService().getDataFromStorage('db_token');
    if (token == null) {
      return '/login';
    }
    return null;
  },
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: 'LogIn',
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: 'SignUp',
      path: '/signup',
      builder: (context, state) => SignUpScreen(),
      routes: [
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          name: 'Otp',
          path: 'otp',
          builder: (context, state) => const OtpScreen(),
          routes: [
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              name: 'Password',
              path: 'password',
              builder: (context, state) => PasswordScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: 'Home',
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
  errorBuilder: (context, state) => const ErrorScreen(),
);
