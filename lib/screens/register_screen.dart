import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmpasswordTextController = TextEditingController();

  void Register() async {
    if (!_formKey.currentState!.validate())
      return;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailTextController.text,
      password: passwordTextController.text
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Inscription ok')));
    } on FirebaseAuthException catch(e) {
      final msg = switch(e.code) {
        'email-already-in-use' => 'Email déjà utilisé',
        'invalid-email' => 'Email invalide',
        'weak-password' => 'Mot de passe trop faible',
        _=> 'Erreur : ${e.code}',
      };

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inscription'), titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),backgroundColor: Colors.blue.shade900),
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
              TextFormField(
                controller: passwordTextController,
                decoration: InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
              ),
              TextFormField(
                controller: confirmpasswordTextController,
                decoration: InputDecoration(labelText: 'Confirmer le mot de passe'),
                obscureText: true,
              ),
              Spacer(flex: 5),
              Material(
                elevation: 5,
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.circular(15),
                child: MaterialButton(
                  onPressed: Register,
                  child: Stack(
                    children: [
                      Text('Se connecter', style: TextStyle(
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