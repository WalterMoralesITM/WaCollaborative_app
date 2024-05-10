import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wa_collaborative/pages/authentication/profile_page.dart';

import '../../models/user.dart';
import '../../repository/authentication_repository.dart';
import '../../repository/user_repository.dart';
import '../customWidges/sized_box_line_break.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  final StreamController<User> _userController = StreamController<User>();
  final UserRepository _userRepository = UserRepository();
  final AuthRepository _authRepository = AuthRepository();
  late User _user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _initializeFields() {
    _nameController = TextEditingController(text: _user.fullName);
    _phoneController = TextEditingController(text: _user.phoneNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _getUser() async {
    String? bearerToken = await _authRepository.getToken();
    Map<String, dynamic>? userData =
    await _userRepository.getStoredUserData(false);
    _user = User.fromJson(userData);
    _userController.add(_user);
    _initializeFields();
  }

  Future<void> _updateUser(var context) async {
    await _userRepository.updateUser(_user);
    //Navigator.of(context).pop(); // Cierra la ventana emergente
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
  }

  Future<void> _clicOnSave() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Guardar"),
          content: const Text("¿Está seguro que desea guardar los cambios?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra la ventana emergente
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                _updateUser(context); // Llama a la función para cerrar sesión
              },
              child: const Text('Sí'),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: StreamBuilder<User>(
          stream: _userController.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            var user = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.network(
                        _user.photo,
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                  TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Nombre',
                      prefixIcon: Icon(Icons.person),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _user.fullName = value;
                      });
                    },
                  ),
                  SizedBoxLineBreak(),
                  TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      hintText: 'Teléfono',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _user.phoneNumber = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _clicOnSave,
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

