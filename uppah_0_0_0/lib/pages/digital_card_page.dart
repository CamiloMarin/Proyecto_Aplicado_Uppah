import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uppah_0_0_0/main.dart';
import 'package:vibration/vibration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:google_fonts/google_fonts.dart';

// Paginas
import 'package:uppah_0_0_0/pages/home_page.dart';
// NFC
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:convert' show utf8;

/// Global flag if NFC is avalible
bool isNfcAvalible = false;

// Convertidor de String a UTF8
var encoded = utf8.encode('Holaa munditooo');
var decoded = utf8.decode(encoded);

// import 'package:flutter_nfc_kit/flutter_nfc_kit.dart' as ios;

class DigitalCard extends StatefulWidget {
  const DigitalCard({super.key});

  @override
  State<DigitalCard> createState() => _DigitalCardState();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for the line below
  isNfcAvalible = await NfcManager.instance.isAvailable();
  runApp(const MyApp());
}

class _DigitalCardState extends State<DigitalCard> {
  final user = FirebaseAuth.instance.currentUser!;
  bool listenerRunning = false; // Var que reviza si el nfc está buscando un tag
  bool writeOnNextContact = false; // Para android, para que no  mas de 1 tag

  bool isEnabled = true; // si se ha clickeado una vez
  bool isGreen = false; // Botón encendido
  Image Btn_Rojo = Image.asset("assets/unlocked (1).png");
  Image Btn_verde = Image.asset("assets/unlocked.png");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 00.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tu ',
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 35.0,
                          ),
                        ),
                        Text(
                          'Carnet digital',
                          style: GoogleFonts.quicksand(
                            color: Color.fromARGB(255, 255, 106, 0),
                            fontWeight: FontWeight.w600,
                            fontSize: 35.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 20,
                thickness: 2,
                indent: 80,
                endIndent: 80,
                color: Color.fromARGB(255, 255, 106, 0),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 00.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/CarnetDigital.PNG',
                            width: 288, height: 400, fit: BoxFit.cover)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: isGreen ? Btn_verde : Btn_Rojo,
                          onPressed: isEnabled
                              ? () async {
                                  // se cambia el icono a verde**
                                  isEnabled = false;
                                  setState(() {
                                    if (isEnabled == false) {
                                      isGreen = !isGreen;
                                    }
                                  });
                                  //vibra el celular
                                  Vibration.vibrate(duration: 700);

                                  /*  // Reviza si hay disponibilidad para usar el nfc en el dispositivo
                                  var availability =
                                      await FlutterNfcKit.nfcAvailability;
                                  if (availability != NFCAvailability.available) {
                                    //  oh sht..
      
                                    await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Hubo un problema'),
                                        content: const Text(
                                            'Dispositivo nfc (near field communication) inactivo o inexistente, por favor actívelo si es posible.'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              // Aqui se cambia el icono a rojo**
      
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop(); // dismisses only the dialog and returns nothing
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    // si hay disponibilidad del nfc:
                                    print('ombe si funciona');
      
                                    // timeout, si no se escanea nada en un tiempo determinado
                                    var tag = await FlutterNfcKit.poll(
                                      timeout: const Duration(seconds: 15),
                                      androidPlatformSound: true,
                                      androidCheckNDEF: false,
                                      readIso14443A: true,
                                      readIso14443B: true,
                                      readIso15693: true,
                                      readIso18092: false,
                                    );
      
                                    // write NDEF records if applicable
                                    if (tag.ndefWritable ?? false) {
                                      // decoded NDEF records
                                      await FlutterNfcKit.writeNDEFRecords([
                                        ndef.UriRecord.fromString(
                                            "Hola Mundito :)")
                                      ]);
                                      // raw NDEF records
                                      await FlutterNfcKit.writeNDEFRawRecords([
                                        NDEFRawRecord("00", "0001", "0002",
                                            ndef.TypeNameFormat.unknown)
                                      ]);
                                    }
                                    setState(() {
                                      isEnabled = true;
                                      print('ADIOSSSS');
                                    });
                                    // Call finish() only once
                                    await FlutterNfcKit.finish();
                                  } */
                                }
                              : null,
                          iconSize: 100.0,
                          splashRadius: 70,
                        ),
                      ],
                    )
                  ],
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
    );
  }

  //Helper method to show a quick message
  void _alert(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        duration: const Duration(
          seconds: 2,
        ),
      ),
    );
  }

  Future<void> _listenForNFCEvents() async {
    //Always run this for ios but only once for android
    if (Platform.isAndroid && listenerRunning == false || Platform.isIOS) {
      //Android supports reading nfc in the background, starting it one time is all we need
      if (Platform.isAndroid) {
        _alert(
          'NFC listener running in background now, approach tag(s)',
        );
        //Update button states
        setState(() {
          listenerRunning = true;
        });
      }

      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          bool succses = false;
          //Try to convert the raw tag data to NDEF
          final ndefTag = Ndef.from(tag);
          //If the data could be converted we will get an object
          if (ndefTag != null) {
            // If we want to write the current counter vlaue we will replace the current content on the tag
            if (writeOnNextContact) {
              //Ensure the write flag is off again
              setState(() {
                writeOnNextContact = false;
              });
              //Create a 1Well known tag with en as language code and 0x02 encoding for UTF8
              final ndefRecord = NdefRecord.createText((decoded));
              //Create a new ndef message with a single record
              final ndefMessage = NdefMessage([ndefRecord]);
              //Write it to the tag, tag must still be "connected" to the device
              try {
                //Any existing content will be overrwirten
                await ndefTag.write(ndefMessage);
                _alert('Mensaje escrito con exito');
                succses = true;
              } catch (e) {
                _alert("Error, vuelve a intentarlo");
              }
            }

            //The NDEF Message was already parsed, if any
            else if (ndefTag.cachedMessage != null) {
              var ndefMessage = ndefTag.cachedMessage!;
              //Each NDEF message can have multiple records, we will use the first one in our example
              if (ndefMessage.records.isNotEmpty &&
                  ndefMessage.records.first.typeNameFormat ==
                      NdefTypeNameFormat.nfcWellknown) {
                //If the first record exists as 1:Well-Known we consider this tag as having a value for us
                final wellKnownRecord = ndefMessage.records.first;

                ///Payload for a 1:Well Known text has the following format:
                ///[Encoding flag 0x02 is UTF8][ISO language code like en][content]
                if (wellKnownRecord.payload.first == 0x02) {
                  //Now we know the encoding is UTF8 and we can skip the first byte
                  final languageCodeAndContentBytes =
                      wellKnownRecord.payload.skip(1).toList();
                  //Note that the language code can be encoded in ASCI, if you need it be carfully with the endoding
                  final languageCodeAndContentText =
                      utf8.decode(languageCodeAndContentBytes);
                  //Cutting of the language code
                  final payload = languageCodeAndContentText.substring(2);

                  //Parsing the content to int
                  final storedCounters = int.tryParse(payload);
                  if (storedCounters != null) {
                    succses = true;
                    _alert('Counter restored from tag');
                    setState(() {
                      decoded = storedCounters as String;
                    });
                  }
                }
              }
            }
          }
          //Due to the way ios handles nfc we need to stop after each tag
          if (Platform.isIOS) {
            NfcManager.instance.stopSession();
          }
          if (succses == false) {
            _alert(
              'Tag was not valid',
            );
          }
        },
        // Required for iOS to define what type of tags should be noticed
        pollingOptions: {
          NfcPollingOption.iso14443,
          NfcPollingOption.iso15693,
        },
      );
    }
  }
}
