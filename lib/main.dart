import 'package:flutter/material.dart';
import 'package:my_app/components/components.dart';
import 'package:my_app/screens/screens.dart';
import 'package:my_app/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatefulWidget {
  const AppState({super.key});

  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My App',
        initialRoute: 'splash',
        routes: {
          '/': (_) => const HomeScreen(),
          'splash': (_) => const SplashScreen(),
          'login': (_) => const LoginScreen(),
          'register': (_) => const RegisterScreen(),
        },
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
            appBarTheme:
                const AppBarTheme(elevation: 0, color: Colors.indigo)));
  }
}
