import 'package:flutter/material.dart';
import 'package:my_app/screens/screens.dart';
import 'package:my_app/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<AuthService>(builder: (context, auth, child) {
        if (!auth.authentificated) {
          return ListView(
            children: [
              // Vista personalizada para el encabezado cuando no está autenticado
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/utils/sidebar_fondo2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Alineado a la izquierda
                  children: [
                    // CircleAvatar a la izquierda
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2018/11/13/22/01/avatar-3814081_640.png',
                      ),
                    ),
                    const SizedBox(
                        height: 10), // Espaciado entre el avatar y los textos
                    const Text(
                      'Identificate o registrate',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    /*const Text(
                      'Usuario no autenticado',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const Text(
                      'Por favor, inicie sesión',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),*/
                  ],
                ),
              ),
              // Otros elementos del Drawer
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Iniciar sesión'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_add),
                title: const Text('Registrarse'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
              ),
              const Divider(
                thickness: 3,
                indent: 15,
                endIndent: 15,
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const Text('Carrito de compras'),
                onTap: () {
                  // Acción para mostrar una muestra de ficha médica
                },
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Buscar producto'),
                onTap: () {
                  // Acción para mostrar una muestra de ficha médica
                },
              ),
              const Divider(
                thickness: 3,
                indent: 15,
                endIndent: 15,
              ),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Preguntas Frecuentes'),
                onTap: () {
                  // Acción para mostrar FAQ
                },
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Política de Privacidad'),
                onTap: () {
                  // Acción para mostrar política de privacidad
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Sobre nosostros'),
                onTap: () {
                  // Acción para mostrar política de privacidad
                },
              ),
              /*ListTile(
                leading: const Icon(Icons.play_arrow),
                title: const Text('Fomulario'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateAssistanceScreen()));
                },
              ),*/
            ],
          );
        } else {
          return ListView(
            children: [
              // Vista personalizada para el encabezado cuando está autenticado
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/utils/sidebar_fondo2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Alineado a la izquierda
                  children: [
                    // CircleAvatar a la izquierda
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2017/02/23/13/05/avatar-2092113_1280.png',
                      ),
                    ),
                    const SizedBox(
                        height: 10), // Espaciado entre el avatar y los textos
                    // Los textos debajo del CircleAvatar
                    Text(
                      //auth.user.name,
                      'Diego',
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      //auth.user.email,
                      'diego@gmail.com',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              /*ListTile(
                leading: const Icon(Icons.shop),
                title: const Text('Modulo Compras'),
                onTap: () {
                  print('Módulo Compras seleccionado');
                },
              ),*/
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const Text('Carrito de compras'),
                onTap: () {
                  // Acción para mostrar una muestra de ficha médica
                },
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Buscar producto'),
                onTap: () {
                  // Acción para mostrar una muestra de ficha médica
                },
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text('Historial de compras'),
                onTap: () {
                  // Acción para mostrar una muestra de ficha médica
                },
              ),
              const Divider(
                thickness: 3,
                indent: 15,
                endIndent: 15,
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Mi Perfil'),
                onTap: () {
                  // Acción para editar o ver perfil
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Cerrar sesión'),
                onTap: () {
                  Provider.of<AuthService>(context, listen: false).logout();
                },
              ),
            ],
          );
        }
      }),
    );
  }
}
