import 'package:flutter/material.dart';
import '../customWidges/custom_center_flexible_text_with_icon.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mi perfil'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
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
                        child: Image.asset(
                          'assets/images/homero_simpson.png',
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      child: const Center(
                        child: Text(
                          'Homero Simpson',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                    ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                CustomCenterFlexibleTextWithIcon(
                  iconData:  Icons.email,
                  textValue:  'hjsimpson@plantanuclear.com',
                  sizeText: 15,
                ),
                SizedBox(height: 20),
                CustomCenterFlexibleTextWithIcon(
                  iconData:  Icons.location_city,
                  textValue:  'Sprinfield',
                  sizeText: 15,
                ),
                SizedBox(height: 20),
                CustomCenterFlexibleTextWithIcon(
                  iconData:  Icons.work,
                  textValue:  'Inspector de seguridad - sector 7-G',
                  sizeText: 15,
                ),
                SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfilePage()),
                    );
                  },
                  child: Text('Editar perfil'),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {

                  },
                  child: Text('Cerrar sesión'),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {

                  },
                  child: Text('¿Cambiar tu contraseña?'),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        )
    );
  }
}
