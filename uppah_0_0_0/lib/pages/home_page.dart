import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  int _currentIndex = 0;
  final screens = [
    Center(
        child: Column(
      children: [
        Text('Home Screenaaa'),
        MaterialButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          color: Colors.amber,
          child: Text('salir'),
        )
      ],
    )),
    const Center(child: Text('Fav Screen', style: TextStyle(fontSize: 45))),
    const Center(child: Text('Search Screen', style: TextStyle(fontSize: 45))),
    const Center(child: Text('Profile Screen', style: TextStyle(fontSize: 45)))
  ];

  final colors = [
    Colors.cyan,
    Colors.purple,
    Colors.green,
    Colors.red,
  ];

  @override
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
  }
}
