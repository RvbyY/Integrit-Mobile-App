import 'package:auth_demo/auth_gate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeleteScreen extends StatefulWidget {
    const DeleteScreen({super.key});

    @override
    State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
    final _formKey = GlobalKey<FormState>();
    final user = FirebaseAuth.instance.currentUser;

    void delete() async {
        if (!_formKey.currentState!.validate())
            return;
        try {
            await user?.delete();
            ScaffoldMessenger.of(
                context,
            ).showSnackBar(SnackBar(content: Text('Compte supprimé')));
            if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const AuthGate()),
                (route) => false,
                );
            }
        } on FirebaseAuthException catch (e) {
            final msg = switch (e.code) {
                'user-not-found' => 'Ce compte existe pas',
                _ => 'Erreur : ${e.code}', 
            };
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: Text('Suprimer mon compte'), titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),backgroundColor: Colors.blue.shade900),
            body: Center(
                child: Material(
                    elevation: 5,
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                        children: [
                            Text('Supprimer le compte', style: TextStyle(
                                color: Colors.white,
                            ),)
                        ],
                    ),
                )
            ),
        );
    }
}