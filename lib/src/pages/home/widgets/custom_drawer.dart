import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[200],
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFFF2264B),
            ),
            child: Column(
              children: [
                const Expanded(
                  child: Text(
                    "Heroi, Você ainda não tem cadastro!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.white, width: 2.0),
                      ),
                      minimumSize:
                          MaterialStateProperty.all(const Size(100, 50)),
                    ),
                    child: const Text("Cadastrar-se",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              "Home",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              "Herois",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              "Herois Salvos",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    // Configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Funcionalidade não implementada"),
      content: const Text(
          "Aguarde as próximas atualizações!\nOs melhores heróis estão por vir!\n\nAtenciosamente,\nEquipe Find Soluções"),
      actions: [
        TextButton(
          child: const Text("Cancelar"),
          onPressed: () {
            // Fechar o AlertDialog
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            // Lógica ao pressionar o botão OK
            Navigator.of(context).pop(); // Fechar o AlertDialog
          },
        ),
      ],
    );

    // Mostra o AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
