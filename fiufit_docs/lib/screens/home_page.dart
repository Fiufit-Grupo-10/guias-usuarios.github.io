import 'dart:io';
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

  final filePathApp = 'docs_card_app.txt';
  final filePathWeb = 'docs_card_back.txt';
  Future<List<DocCards>> fromFile(String path) async {
    List<DocCards> docCardsList = [];
    String contents = await rootBundle.loadString(path);

    print("contents: $contents");
    List<String> lines = contents.split('\n');

    for (int i = 0; i < lines.length; i += 3) {
      String title = lines[i];
      String pathImage = lines[i + 1];
      String description = lines[i + 2];

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

  Future<bool> getDocs() async {
    listaDocsApp = await fromFile(filePathApp);
    listaDocsWeb = await fromFile(filePathWeb);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          "FiuFit - Guias de Usuario",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
      ),
      body: FutureBuilder(
          future: getDocs(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return SingleChildScrollView(
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
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
                                  onTap: () => Navigator.pushNamed(
                                      context, "doc",
                                      arguments: [listaDocsApp[index]]));
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text("Guia de usuario del backoffice",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24)),
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
                                  onTap: () => Navigator.pushNamed(
                                      context, "doc",
                                      arguments: [listaDocsWeb[index]]));
                            }),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
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
