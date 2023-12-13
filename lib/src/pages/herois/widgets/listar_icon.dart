import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'icon_op.dart';

class ListaCategoria extends StatelessWidget {
  ListaCategoria({super.key});

  final Uri _url = Uri.parse('https://pt.wikipedia.org/wiki/Marvel_Comics');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            child: const Column(
              children: [
                IconItens(image: "assets/icons/wikipedia.png"),
                Text(
                  "Wiki",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            onTap: () {
              _launchUrl();
            },
          ),
          const Column(
            children: [
              IconItens(image: "assets/icons/filme.png"),
              Text(
                "Filmes",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Column(
            children: [
              IconItens(image: "assets/icons/hq.png"),
              Text(
                "HQs",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
