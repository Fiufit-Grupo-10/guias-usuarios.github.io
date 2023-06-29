import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:image_network/image_network.dart';
import '../models/doc_cards.dart';

class DocPage extends StatelessWidget {
  const DocPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final arguments =
        ModalRoute.of(context)!.settings.arguments as List<Object?>;

    final DocCards docPage = arguments[0] as DocCards;

    final expandedHeight = size.height * 0.7;
    final width = size.width * 0.3;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text(
            "",
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
        body: Row(
          children: [
            SizedBox(
              height: expandedHeight,
              width: size.width * 0.5,
              child: CarouselSlider.builder(
                  itemCount: docPage.pathImages.length,
                  itemBuilder: (_, index, __) {
                    return ImageNetwork(
                        fitWeb: BoxFitWeb.contain,
                        image: docPage.pathImages[index],
                        height: expandedHeight,
                        width: width);
                  },
                  options: CarouselOptions(
                    viewportFraction: 0.5,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.5,
                    enableInfiniteScroll: false,
                    autoPlay: true,
                  )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.45,
                  child: Text(
                    docPage.title,
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: Colors.indigo),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: size.width * 0.45,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      docPage.description,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Colors.indigo),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
