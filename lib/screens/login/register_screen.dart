import 'package:flutter/material.dart';
import 'package:my_app/providers/providers.dart';
import 'package:my_app/services/auth/auth_service.dart';
import 'package:my_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regístrate'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20), // Espacio a los lados
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100), // Espaciado superior
              // Formulario de registro centrado
              ChangeNotifierProvider(
                create: (_) => registerformprovider(),
                child: _RegisterForm(),
              ),
              const SizedBox(height: 30), // Espaciado entre formulario y texto
              // Texto de bienvenida
              const Text(
                'Bienvenido a nuestra App movil',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50), // Espaciado inferior
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<registerformprovider>(context);

    return Form(
      key: registerForm.formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            onChanged: (value) => registerForm.firstname = value,
            decoration: const InputDecoration(
              hintText: 'Nombre',
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            onChanged: (value) => registerForm.lastname = value,
            decoration: const InputDecoration(
              hintText: 'Apellidos',
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => registerForm.email = value,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) => registerForm.password = value,
            decoration: const InputDecoration(
              hintText: 'Contraseña',
            ),
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.blue,
            onPressed: registerForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    if (!registerForm.isValidForm()) return;
                    registerForm.isLoading = true;

                    final authService =
                        Provider.of<AuthService>(context, listen: false);

                    String respuesta = await authService.register(
                        registerForm.firstname,
                        registerForm.lastname,
                        registerForm.email,
                        registerForm.password);

                    if (respuesta == 'correcto') {
                      registerForm.isLoading = false;
                      Navigator.pop(context);
                    } else {
                      registerForm.isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Hubo un error al registrarse, vuelve a intentarlo.'),
                        ),
                      );
                    }
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                registerForm.isLoading ? 'Espere' : 'Registrarse',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DialogoAlerta extends StatelessWidget {
  final String mensaje;

  const _DialogoAlerta({required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Error'),
      content: Text(mensaje),
    );
  }
}
