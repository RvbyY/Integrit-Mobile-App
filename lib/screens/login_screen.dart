import 'package:auth_demo/auth_gate.dart';
import 'package:auth_demo/screens/forgot_password.dart';
import 'package:auth_demo/screens/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void login() async {
    if (!_formKey.currentState!.validate())
      return;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Connexion ok')));
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const AuthGate()),
        (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      final msg = switch (e.code) {
        'user-disabled' => 'Compte est desactivé',
        'invalid-email' => 'Email invalide',
        'wrong-password' => 'Mot de passe invalide',
        'user-not-found' => 'Compte existe pas',
        _ => 'Erreur : ${e.code}',
      };
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connexion'), titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),backgroundColor: Colors.blue.shade900),
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
              Spacer(flex: 1),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Vous n'avez pas de compte ? ", style: TextStyle(color: Colors.black)),
                    TextSpan(text: "inscrivez-vous", style: TextStyle(color: Colors.blue.shade900, decoration: TextDecoration.underline),recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        TextStyle(color: Colors.black);
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (_) => const RegisterScreen(),
                          ),
                        );
                       },
                    )
                  ]
                ),
              ),
              RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Mot de passe oublié", style: TextStyle(color: Colors.blue.shade900, decoration: TextDecoration.underline), recognizer: TapGestureRecognizer()
                        ..onTap = () {
                        TextStyle(color: Colors.black);
                        Navigator.push(
                          context, MaterialPageRoute(
                              builder: (_) => const ForgotScreen(),
                          ),
                        );
                        })
                    ]
                  )),
              Spacer(flex: 2),
              Material(
                elevation: 5,
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.circular(15),
                child: MaterialButton(
                  onPressed: login,
                  child: Stack(
                    children: [
                      Text('Se connecter', style: TextStyle(
                        color: Colors.white,
                      ),),
                    ]
                  ),
                ),
              ),
              Spacer(flex: 70),
            ],
          )
        )
      ),
    );
  }
}