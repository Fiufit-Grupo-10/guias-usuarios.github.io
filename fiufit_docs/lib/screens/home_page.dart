import 'dart:io';
import 'package:fiufit_docs/docs_card_app.dart';
import 'package:fiufit_docs/docs_card_web.dart';
import 'package:flutter/material.dart';
import '../models/doc_cards.dart';

import 'package:flutter/services.dart' show rootBundle;

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DocCards> listaDocsApp = [];
  List<DocCards> listaDocsWeb = [];

  List<DocCards> fromFile(List<Map<String, dynamic>> docs) {
    List<DocCards> docCardsList = [];

    for (var d in docs) {
      String title = d['title'];
      String pathImage = d['images'];
      String description = d['descr'];

      DocCards docCard = DocCards(
        title: title,
        pathImages: pathImage.split(" "),
        description: description,
      );

      docCardsList.add(docCard);
    }

    print("docCardsList: $docCardsList");
    return docCardsList;
  }

  bool getDocs() {
    listaDocsApp = fromFile(docsCardApp);
    listaDocsWeb = fromFile(docsCardWeb);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    getDocs();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text(
            "FiuFit - Guias de Usuario",
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: SizedBox(
              width: size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Guia de usuario de la aplicación",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: listaDocsApp.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            child: Text(
                              listaDocsApp[index].title,
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.blue),
                            ),
                            onTap: () => Navigator.pushNamed(context, "doc",
                                arguments: [listaDocsApp[index]]));
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text("Guia de usuario del backoffice",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: listaDocsWeb.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            child: Text(
                              listaDocsWeb[index].title,
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.blue),
                            ),
                            onTap: () => Navigator.pushNamed(context, "doc",
                                arguments: [listaDocsWeb[index]]));
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}

class CustomDocCard extends StatelessWidget {
  const CustomDocCard({super.key, required this.title, required this.docs});
  final String title;
  final List<Map<String, dynamic>> docs;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        ListView.builder(
            itemCount: docs.length, itemBuilder: (context, index) {})
      ],
    );
  }
}
