import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management/feature/navigation/view/navigation_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../feature/login/view/login_screen.dart';

class AuthenticateGate extends StatelessWidget {
  const AuthenticateGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          // check if there is a valid session currently
          final session = snapshot.hasData? snapshot.data!.session : null;
          if (session != null){
            return NavigationScreen();
          } else {
            return LoginScreen();
          }
        }
    );
  }
}