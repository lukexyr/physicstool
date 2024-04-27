import 'package:flutter/material.dart';
import 'package:physicstool/components/my_button.dart';
import 'package:physicstool/pages/home_page.dart';
import 'package:physicstool/pages/user_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _showLoginDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Schlüssel eingeben'),
          content: TextField(
            controller: controller,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Schlüssel',
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Abbrechen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Anmelden'),
              onPressed: () {
                if (controller.text == 'TT007') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Guck lieber nochmal in die Formelsammlung')));
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            'Freunde des Friedens!',
            style: TextStyle(fontSize: 50),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: MyButton(
                  name: 'Schüler',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => UserPage()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: MyButton(
                  name: 'Teubert',
                  onPressed: () => _showLoginDialog(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
