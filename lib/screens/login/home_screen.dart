import 'package:flutter/material.dart';
//import 'package:my_app/components/utils/sidebar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_app/components/components.dart';
import 'package:my_app/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    readToken();
    super.initState();
  }

  void readToken() async {
    String? token = await storage.read(key: 'token');
    // ignore: use_build_context_synchronously
    Provider.of<AuthService>(context, listen: false).tryToken(token);
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body:
          Text('Data Home!', style: Theme.of(context).textTheme.headlineSmall),
    );
  }
}
