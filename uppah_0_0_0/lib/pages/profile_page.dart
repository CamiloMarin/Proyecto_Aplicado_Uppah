import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String myFirstName = '';
  String myLastName = '';
  String myEmail = '';
  String myCareer = '';
  String myDocument = '';
  String myUID = FirebaseAuth.instance.currentUser!.uid.toString();
  File? _image;
  final FirebaseStorage storage = FirebaseStorage.instance;

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

  Future<String> getDownloadUrl(String imageName) async {
    String downloadURL =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80';
    try {
      await storage
          .ref('${imageName}_main_picture')
          .getDownloadURL()
          .then((value) {
        downloadURL = value;
        return downloadURL;
      });
    } on FirebaseException catch (e) {
      print("errorasdad: $e");
      if (e.code == 'object-not-found') {
        print("now hereaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        await storage.ref('BotonPerfilAlt.png').getDownloadURL().then((value) {
          downloadURL = value;
          return downloadURL;
        });
      }
    }
    print("putooooooooooo");
    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    Future uploadPic(BuildContext context) async {
      String fileName = myUID + '_main_picture';
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = firebaseStorageRef.putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask;
      setState(() {
        print("subida");
      });
    }

    Future getImage() async {
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;
        final imageTemp = File(image.path);

        setState((() {
          this._image = imageTemp;
          uploadPic(context);
        }));
      } on PlatformException catch (e) {
        print('Failed to pick image: $e');
      }
    }

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background_profile.jpeg'),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: FutureBuilder(
                    future: getDownloadUrl(myUID),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return Align(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 128,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 128,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: Material(
                                        child: Image.network(
                                      snapshot.data!,
                                      fit: BoxFit.fitWidth,
                                      width: 250,
                                      height: 250,
                                    )),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 4,
                                child: ClipOval(
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    color: Color.fromARGB(255, 255, 106, 0),
                                    padding: EdgeInsets.all(10),
                                    child: IconButton(
                                      onPressed: () {
                                        getImage();
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.userPen,
                                        size: 25.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          !snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      return const CircularProgressIndicator();
                    }),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 300,
                  child: Center(
                    child: Column(
                      children: [
                        FutureBuilder(
                          future: dataFetch,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) return Text('');
                            return Text(
                              "$myFirstName" + " $myLastName",
                              style: GoogleFonts.quicksand(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 25.0,
                              ),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                        Divider(
                          height: 10,
                          thickness: 1,
                          color: Color.fromARGB(255, 255, 106, 0),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        FutureBuilder(
                          future: dataFetch,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) return Text('');
                            return Text(
                              "$myCareer",
                              style: GoogleFonts.quicksand(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 25.0,
                              ),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                        Divider(
                          height: 10,
                          thickness: 1,
                          color: Color.fromARGB(255, 255, 106, 0),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        FutureBuilder(
                          future: dataFetch,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) return Text('');
                            return Text(
                              "$myEmail",
                              style: GoogleFonts.quicksand(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 25.0,
                              ),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                        Divider(
                          height: 10,
                          thickness: 1,
                          color: Color.fromARGB(255, 255, 106, 0),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        FutureBuilder(
                          future: dataFetch,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) return Text('');
                            return Text(
                              "$myDocument",
                              style: GoogleFonts.quicksand(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 25.0,
                              ),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                        Divider(
                          height: 10,
                          thickness: 1,
                          color: Color.fromARGB(255, 255, 106, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          backgroundColor: Colors.white,
          child: Image.asset("assets/BackArrow.png"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
      child: Icon(
        FontAwesomeIcons.camera,
        size: 30.0,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      all: 0,
      color: color);

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get()
        .then((docSnapshot) {
      myFirstName = docSnapshot.data()!['Nombres'];
      myLastName = docSnapshot.data()!['Apellidos'];
      myCareer = docSnapshot.data()!['Carrera'];
      myDocument = docSnapshot.data()!['Cedula'];
      myEmail = docSnapshot.data()!['Correo'];
    });
  }
}
