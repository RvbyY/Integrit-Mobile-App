import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailTextController = TextEditingController();

  void Forgot() async {
    if (!_formKey.currentState!.validate())
      return;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailTextController.text
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Changement de mdp ok')));
    } on FirebaseAuthException catch(e) {
      final msg = switch(e.code) {
        'invalid-email' => 'Email invalide',
        _=> 'Erreur : ${e.code}',
      };

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mot de passe oublié'), titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),backgroundColor: Colors.blue.shade900),
      body: Center(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailTextController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                Spacer(flex: 5),
                Material(
                  elevation: 5,
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(15),
                  child: MaterialButton(
                    onPressed: Forgot,
                    child: Stack(
                        children: [
                          Text('Changer de mot de passe', style: TextStyle(
                            color: Colors.white,
                          ),),
                        ]
                    ),
                  ),
                ),
                Spacer(flex: 100),
              ],
            )),
      ),
    );
  }
}