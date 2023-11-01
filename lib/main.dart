import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentapp/authentication/auth_bloc.dart';
import 'package:rentapp/model/custom_themes.dart';
import 'package:rentapp/router/router_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RentApp());
}

class RentApp extends StatelessWidget {
  const RentApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(),
          ),
        ],
        child: MaterialApp.router(
          themeMode: ThemeMode.light,
          theme: CustomTheme().lightTheme(),
          routerConfig: routerConfiguration,
        ),
      ),
    );
  }
}
