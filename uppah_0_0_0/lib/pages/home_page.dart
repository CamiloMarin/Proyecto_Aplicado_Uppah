import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:uppah_0_0_0/pages/gym_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  String myFirstName = '';
  String myEmail = '';

  int _currentIndex = 0;
  final screens = [
    Center(
        child: Column(
      children: [
        Text('Home Screenaaaaaa'),
        MaterialButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          color: Colors.amber,
          child: Text('salir'),
        )
      ],
    )),
    /* Center(
      child: FutureBuilder(
        future: () async {
          final firebaseUser = FirebaseAuth.instance.currentUser!;
          await FirebaseFirestore.instance
              .collection('users')
              .doc(firebaseUser.uid)
              .get()
              .then((docSnapshot) {
            myFirstName = docSnapshot.data()!['Nombres'];
          });
        }(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done)
            return Text("Loading");
          return Text("Nombre: $myFirstName");
        },
      ),
    ), */
    const Center(child: Text('Search Screen', style: TextStyle(fontSize: 45))),
    const Center(child: Text('Profile Screen', style: TextStyle(fontSize: 45)))
  ];

  final colors = [
    Colors.cyan,
    Colors.purple,
    Colors.green,
    Colors.red,
  ];

/*   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyApp'),
        centerTitle: true,
        backgroundColor: colors[_currentIndex],
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(bottom: 10),
        child: GNav(
            color: colors[_currentIndex],
            tabBackgroundColor: colors[_currentIndex],
            selectedIndex: _currentIndex,
            tabBorderRadius: 5,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            onTabChange: (index) => {setState(() => _currentIndex = index)},
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Inicio',
                iconActiveColor: Colors.white,
                textColor: Colors.white,
              ),
              GButton(
                icon: Icons.favorite_border,
                text: 'Favoritos',
                iconActiveColor: Colors.white,
                textColor: Colors.white,
              ),
              GButton(
                icon: Icons.search,
                text: 'Buscar',
                iconActiveColor: Colors.white,
                textColor: Colors.white,
              ),
              GButton(
                icon: Icons.person,
                text: 'Perfil',
                iconActiveColor: Colors.white,
                textColor: Colors.white,
              ),
            ]),
      ),
    );
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: _fetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
              return Text('Cargando...');
            return Text("Hola $myFirstName");
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.amber[200],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: _fetch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Text('Cargando');
                    return Text("Tu correo es: $myEmail");
                  },
                ),
                MaterialButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  color: Colors.amber,
                  child: Text('salir'),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GymPage()),
                    );
                  },
                  color: Colors.amber,
                  child: Text('Gimnasio'),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(bottom: 10),
        child: GNav(
            color: colors[_currentIndex],
            tabBackgroundColor: colors[_currentIndex],
            selectedIndex: _currentIndex,
            tabBorderRadius: 5,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            onTabChange: (index) => {setState(() => _currentIndex = index)},
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Inicio',
                iconActiveColor: Colors.white,
                textColor: Colors.white,
              ),
              GButton(
                icon: Icons.favorite_border,
                text: 'Favoritos',
                iconActiveColor: Colors.white,
                textColor: Colors.white,
              ),
              GButton(
                icon: Icons.search,
                text: 'Buscar',
                iconActiveColor: Colors.white,
                textColor: Colors.white,
              ),
              GButton(
                icon: Icons.person,
                text: 'Perfil',
                iconActiveColor: Colors.white,
                textColor: Colors.white,
              ),
            ]),
      ),
    );
  }

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get()
        .then((docSnapshot) {
      myFirstName = docSnapshot.data()!['Nombres'];
      myEmail = docSnapshot.data()!['Correo'];
    });
  }
}
