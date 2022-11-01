import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uppah_0_0_0/pages/NavBar.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:uppah_0_0_0/pages/gym_page.dart';
import 'package:uppah_0_0_0/pages/reservas_page.dart';
import 'package:uppah_0_0_0/pages/digital_card_page.dart';
import 'package:uppah_0_0_0/pages/profile_page.dart';
import 'package:uppah_0_0_0/utils/invest_groups.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _keyCoso = GlobalKey();
  final user = FirebaseAuth.instance.currentUser!;

  String myFirstName = '';
  String myEmail = '';

  List<InvestGroups> investGroupsList = [
    InvestGroups('assets/grupos_investigacion_1.jpg', 'Educación',
        'Estudiantes hacen coso'),
    InvestGroups('assets/grupos_investigacion_2.jpg', 'Educación',
        'Estudiantes hacen coso'),
    InvestGroups('assets/grupos_investigacion_3.jpg', 'Educación',
        'Estudiantes hacen coso'),
    InvestGroups('assets/grupos_investigacion_3.jpg', 'Educación',
        'Estudiantes hacen coso'),
    InvestGroups('assets/grupos_investigacion_3.jpg', 'Educación',
        'Estudiantes hacen coso'),
  ];

  late Future dataFetch;
  late Future profileImageFuture;

  @override
  void initState() {
    super.initState();
    dataFetch = _getDataFetch();
    //profileImageFuture = getDownloadUrl(context);
  }

  _getDataFetch() async {
    return _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyCoso,
      drawer: const NavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisSize: MainAxisSize.max,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: null,
                          icon: Image.asset("assets/uppah_simple_orange.png"),
                          iconSize: 60.0,
                          //padding: EdgeInsets.symmetric(horizontal: 50.0),
                        ),
                        // Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()),
                            );
                          },
                          icon: Image.asset("assets/BotonPerfil.png"),
                          iconSize: 50.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '¡',
                    style: GoogleFonts.quicksand(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 25.0,
                    ),
                  ),
                  Text(
                    'Bienvenidx ',
                    style: GoogleFonts.quicksand(
                      color: Color.fromARGB(255, 255, 106, 0),
                      fontWeight: FontWeight.w600,
                      fontSize: 25.0,
                    ),
                  ),
                  FutureBuilder(
                    future: dataFetch,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done)
                        return Text('');
                      return Text(
                        "$myFirstName!",
                        style: GoogleFonts.quicksand(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.0,
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                '¿Qué quieres hacer hoy?',
                style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 60.0, top: 25.0, right: 60.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DigitalCard()),
                                );
                              },
                              icon: Image.asset("assets/BotonCarnet.png"),
                              iconSize: 70.0,
                            ),
                            Text('Carnet',
                                style: GoogleFonts.quicksand(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.0,
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: null,
                              icon: Image.asset("assets/BotonHorario.png"),
                              iconSize: 70.0,
                            ),
                            Text('Horario',
                                style: GoogleFonts.quicksand(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.0,
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ReservasPage()),
                                );
                              },
                              icon: Image.asset("assets/BotonReservas.png"),
                              iconSize: 70.0,
                            ),
                            Text('Reservas',
                                style: GoogleFonts.quicksand(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.0,
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: null,
                              icon: Image.asset("assets/BotonCalculadora.png"),
                              iconSize: 70.0,
                            ),
                            Text('Calculadora',
                                style: GoogleFonts.quicksand(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.0,
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: null,
                              icon: Image.asset("assets/BotonAgenda.png"),
                              iconSize: 70.0,
                            ),
                            Text('Agenda',
                                style: GoogleFonts.quicksand(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.0,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Grupos ',
                    style: GoogleFonts.quicksand(
                      color: Color.fromARGB(255, 255, 106, 0),
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    'que podrían ser de tu ',
                    style: GoogleFonts.quicksand(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    'interés',
                    style: GoogleFonts.quicksand(
                      color: Color.fromARGB(255, 255, 106, 0),
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 250,
                child: ScrollSnapList(
                  initialIndex: 1,
                  itemBuilder: _buildListItem,
                  itemCount: investGroupsList.length,
                  itemSize: 200,
                  onItemFocus: (index) {},
                  dynamicItemSize: true,
                ),
                //margin: EdgeInsets.symmetric(horizontal: 50)),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                width: 80,
                height: 80,
                child: FittedBox(
                  child: FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Color.fromARGB(255, 255, 106, 0),
                    onPressed: () {
                      _keyCoso.currentState?.openDrawer();
                    },
                    tooltip: 'a cagar',
                    child: Image.asset('assets/BotonFlotanteMenu.png'),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Container(
                width: 80,
                height: 80,
                child: FittedBox(
                  child: FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Color.fromARGB(255, 255, 106, 0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DigitalCard()),
                      );
                    },
                    tooltip: 'a cagar2',
                    child: Image.asset('assets/BotonCarnet.png'),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 20),
              child: Container(
                width: 80,
                height: 80,
                child: FittedBox(
                  child: FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Color.fromARGB(255, 255, 106, 0),
                    onPressed: () => setState(() {}),
                    tooltip: 'a cagar3',
                    child: Image.asset('assets/BotonFlotanteSoporte.png'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildCard() => Container(
        width: 200,
        height: 200,
        color: Colors.red,
      );

  Widget _buildListItem(BuildContext context, int index) {
    InvestGroups investGroups = investGroupsList[index];
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      width: 200,
      height: 300,
      child: Center(
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            child: Column(
              children: [
                Image.asset(
                  investGroups.imagePath,
                  fit: BoxFit.cover,
                  width: 200,
                  height: 240,
                ),
              ],
            ),
          ),
        ),
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
