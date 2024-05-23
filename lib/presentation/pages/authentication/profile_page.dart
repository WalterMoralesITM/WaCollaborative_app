import 'package:flutter/material.dart';
import '../../../data/remoteData/authentication_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../domain/entities/user.dart';
import '../../customWidges/custom_center_flexible_text_with_icon.dart';
import '../../customWidges/sized_box_line_break.dart';
import 'change_password_page.dart';
import 'edit_profile_page.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserRepository _userRepository = UserRepository();
  final AuthRepository _authRepository = AuthRepository();
  late User _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    try {
      Map<String, dynamic>? userData = await _userRepository.getStoredUserData(false);
      _user = User.fromJson(userData);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showCerrarSesionConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Cerrar sesión"),
          content: const Text("¿Está seguro que desea cerrar sesión?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra la ventana emergente
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                _cerrarSesion(context); // Llama a la función para cerrar sesión
              },
              child: const Text('Sí'),
            ),
          ],
        );
      },
    );
  }

  void _cerrarSesion(BuildContext context) {
    _authRepository.logOut();
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mi perfil'),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Center(
                        child: Text(
                          _user.fullName,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBoxLineBreak(),
                CustomCenterFlexibleTextWithIcon(
                  iconData: Icons.email,
                  textValue: _user.normalizedEmail,
                  sizeText: 15,
                ),
                SizedBoxLineBreak(),
                CustomCenterFlexibleTextWithIcon(
                  iconData: Icons.location_city,
                  textValue: _user.city.name,
                  sizeText: 15,
                ),
                SizedBoxLineBreak(),
                CustomCenterFlexibleTextWithIcon(
                  iconData: Icons.phone,
                  textValue: _user.phoneNumber,
                  sizeText: 15,
                ),
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfilePage()),
                    );
                  },
                  child: const Text('Editar perfil'),
                ),
                SizedBoxLineBreak(),
                TextButton(
                  onPressed: (){
                    _showCerrarSesionConfirmationDialog(context);
                  },
                  child: const Text('Cerrar sesión'),
                ),
                SizedBoxLineBreak(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordPage()),
                    );
                  },
                  child: const Text('¿Cambiar tu contraseña?'),
                ),
                SizedBoxLineBreak(),
              ],
            ),
          ),
        ),
      );
    }
  }
