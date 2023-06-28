import 'package:fiufit_docs/docs_card_app.dart';
import 'package:fiufit_docs/docs_card_web.dart';
import 'package:flutter/material.dart';
import '../models/doc_cards.dart';
import 'package:url_launcher/url_launcher.dart';

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
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(
                      "Taller de programación 2 - FiuFit",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 50.0),
                    child: Text("Integrantes: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 100.0),
                    child: Text(
                      "\n\t- Axel Kelman \n\t- Franco Gazzola \n\t- Juan Aguirre Braun \n\t- Tomas Emanuel \n\t- Juan Cruz Caserío",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 50.0, top: 20),
                    child: Text("Links: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 60,
                      ),
                      BotonUrl(
                          url1: "github.com",
                          url2: "/orgs/Fiufit-Grupo-10/repositories",
                          text: "GitHub"),
                      BotonUrl(
                          url1: "fiufit-grupo-10.github.io",
                          url2: "/backoffice-deploy.github.io/",
                          text: "BackOffice Web"),
                      BotonUrl(
                          url1: "fiufit-grupo-10.github.io",
                          url2: "/backoffice-deploy.github.io/",
                          text: "Apk"),
                      BotonUrl(
                          url1: "fiufit-grupo-10.github.io",
                          url2: "/backoffice-deploy.github.io/",
                          text: "Documentación"),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    width: double.infinity,
                    height: 5,
                    color: Colors.cyan,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 50.0, bottom: 10),
                    child: Text(
                      "Guias:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70.0),
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
                          const SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: listaDocsApp.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: InkWell(
                                      child: Text(
                                        "- ${listaDocsApp[index].title}",
                                        style: const TextStyle(
                                            fontSize: 22, color: Colors.blue),
                                      ),
                                      onTap: () => Navigator.pushNamed(
                                          context, "doc",
                                          arguments: [listaDocsApp[index]])),
                                );
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text("Guia de usuario del backoffice",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24)),
                          const SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: listaDocsWeb.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: InkWell(
                                      child: Text(
                                        "- ${listaDocsWeb[index].title}",
                                        style: const TextStyle(
                                            fontSize: 22, color: Colors.blue),
                                      ),
                                      onTap: () => Navigator.pushNamed(
                                          context, "doc",
                                          arguments: [listaDocsWeb[index]])),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class BotonUrl extends StatelessWidget {
  const BotonUrl({
    super.key,
    required this.url1,
    required this.url2,
    required this.text,
  });
  final String url1;
  final String url2;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black38.withOpacity(0.4),
          ),
          onPressed: () async {
            await launchUrl(Uri.https(url1, url2));
          },
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          )),
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
