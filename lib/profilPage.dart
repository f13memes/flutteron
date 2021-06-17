import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/services/kullanici_model.dart';

class ProfilPage extends StatefulWidget {
  String profilGosterilecekId;
  ProfilPage({this.profilGosterilecekId});

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  TextEditingController _textEditingController = TextEditingController();
  File guncelFoto;
  String resimId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profil"),
        ),
        body: FutureBuilder(
            future: kullaniciGetir(widget.profilGosterilecekId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Kullanici _gelenKullanici = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircleAvatar(
                            minRadius: 80,
                            backgroundImage:
                                NetworkImage(snapshot.data.profilFotoUrl),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            Text(
                              "Adı-Soyadı:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text(
                              _gelenKullanici.adSoyad,
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            Text(
                              "Kullanici Id:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text(
                              _gelenKullanici.kullaniciId,
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else
                return Center(child: CircularProgressIndicator());
            }));
  }

  kullaniciGetir(String kullaniciId) async {
    DocumentSnapshot _query = await FirebaseFirestore.instance
        .collection("Users")
        .doc(kullaniciId)
        .get();
    Kullanici kullanici = Kullanici.fromMap(_query.data());
    return kullanici;
  }
}
