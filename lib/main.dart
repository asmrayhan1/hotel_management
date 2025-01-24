import 'package:flutter/material.dart';
import 'package:hotel_management/feature/login/view/login_screen.dart';
import 'package:hotel_management/feature/navigation/view/navigation_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/service/authenticate_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://dkcsxccdmdunftexgdkc.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRrY3N4Y2NkbWR1bmZ0ZXhnZGtjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY5Mzc2ODAsImV4cCI6MjA1MjUxMzY4MH0.XREOwZkmieytqmnAnvvp8l8OTZYjuP07_GdNGkGKFng'
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user = AuthService().getCurrentUserEmail();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (user != null)? NavigationScreen() : LoginScreen(),
    );
  }
}