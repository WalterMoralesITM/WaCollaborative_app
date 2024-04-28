import 'package:flutter/material.dart';
import 'package:wa_collaborative/pages/authentication/recover_password_page.dart';
import '../repository/authentication_repository.dart';
import '../shared/home_app_bar_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _passwordVisible = true;

  final AuthRepository _authRepository = AuthRepository();

  Future<void> _signIn() async {
    try {
      final token = await _authRepository.signIn(_email.text, _password.text);
      print('Inicio de sesión exitoso. Token JWT: $token');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePageTabsPage()));
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error al iniciar sesión: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/img.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email)),
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
              value!.isValidEmail() ? null : 'Correo invalido',
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _password,
              obscureText: _passwordVisible,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Contraseña',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(_passwordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                _signIn,
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecoverPasswordPage()),
                );
              },
              child: Text('¿Olvidaste tu contraseña?'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageTabsPage()),
                );
              },
              child: Text('Cliente, esto se borra'),
            ),
          ],
        ),
      ),
      )
    );
  }
}

extension on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}