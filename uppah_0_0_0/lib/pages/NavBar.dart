import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uppah_0_0_0/pages/profile_page.dart';

String? myFirstName;
String? myLastName;

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    _fetch();
    return Drawer(
      backgroundColor: Color.fromARGB(255, 255, 106, 0),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Hola,',
                  style: GoogleFonts.quicksand(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                  ),
                ),
              ),
              accountEmail: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: FutureBuilder(
                  future: _fetch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Text('');
                    return Text(
                      '$myFirstName ' + '$myLastName',
                      style: GoogleFonts.quicksand(
                        color: Color.fromARGB(255, 255, 106, 0),
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    );
                  },
                ),
              ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset('assets/BotonPerfil.png'),
                ),
              ),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 106, 0),
                image: DecorationImage(
                  image: AssetImage('assets/HeaderNavBar.png'),
                  fit: BoxFit.cover,
                ),
              )),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Material(
                elevation: 5,
                child: Container(
                  color: Color.fromARGB(255, 255, 106, 0),
                  height: 62,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListTile(
                      leading: SizedBox(
                          height: 35,
                          child: Image.asset('assets/navbar_icons/user.png')),
                      title: Text('Mi Perfil',
                          style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17.0,
                          )),
                      trailing: SizedBox(
                          height: 40,
                          child: Image.asset(
                              'assets/navbar_icons/angle-small-right.png')),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Material(
              elevation: 5,
              child: Container(
                color: Color.fromARGB(255, 255, 106, 0),
                height: 62,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    leading: SizedBox(
                        height: 35,
                        child: Image.asset('assets/navbar_icons/apps.png')),
                    title: Text('Servicios',
                        style: GoogleFonts.quicksand(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0,
                        )),
                    trailing: SizedBox(
                        height: 40,
                        child: Image.asset(
                            'assets/navbar_icons/angle-small-right.png')),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Material(
              elevation: 5,
              child: Container(
                color: Color.fromARGB(255, 255, 106, 0),
                height: 62,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    leading: SizedBox(
                        height: 35,
                        child:
                            Image.asset('assets/navbar_icons/users-alt.png')),
                    title: Text('Grupos de interés',
                        style: GoogleFonts.quicksand(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0,
                        )),
                    trailing: SizedBox(
                        height: 40,
                        child: Image.asset(
                            'assets/navbar_icons/angle-small-right.png')),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 25,
            thickness: 1,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Material(
              elevation: 5,
              child: Container(
                color: Color.fromARGB(255, 255, 106, 0),
                height: 62,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    leading: SizedBox(
                        height: 35,
                        child: Image.asset('assets/navbar_icons/headset.png')),
                    title: Text('Soporte',
                        style: GoogleFonts.quicksand(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0,
                        )),
                    trailing: SizedBox(
                        height: 40,
                        child: Image.asset(
                            'assets/navbar_icons/angle-small-right.png')),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Material(
              elevation: 5,
              child: Container(
                color: Color.fromARGB(255, 255, 106, 0),
                height: 62,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    leading: SizedBox(
                        height: 35,
                        child: Image.asset('assets/navbar_icons/info.png')),
                    title: Text('Términos y condiciones',
                        style: GoogleFonts.quicksand(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0,
                        )),
                    trailing: SizedBox(
                        height: 40,
                        child: Image.asset(
                            'assets/navbar_icons/angle-small-right.png')),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Material(
              elevation: 5,
              child: Container(
                color: Color.fromARGB(255, 255, 106, 0),
                height: 62,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    leading: SizedBox(
                        height: 35,
                        child: Image.asset('assets/navbar_icons/info.png')),
                    title: Text('Política de privacidad',
                        style: GoogleFonts.quicksand(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0,
                        )),
                    trailing: SizedBox(
                        height: 40,
                        child: Image.asset(
                            'assets/navbar_icons/angle-small-right.png')),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 25,
            thickness: 1,
            color: Colors.white,
          ),
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Material(
                elevation: 5,
                child: Container(
                  color: Color.fromARGB(255, 255, 106, 0),
                  height: 62,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListTile(
                      leading: SizedBox(
                          height: 35,
                          child: Image.asset(
                              'assets/navbar_icons/sign-out-alt.png')),
                      title: Text('Cerrar sesión',
                          style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17.0,
                          )),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_fetch() async {
  final firebaseUser = FirebaseAuth.instance.currentUser!;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(firebaseUser.uid)
      .get()
      .then((docSnapshot) {
    myFirstName = docSnapshot.data()!['Nombres'];
    myLastName = docSnapshot.data()!['Apellidos'];
  });
}
