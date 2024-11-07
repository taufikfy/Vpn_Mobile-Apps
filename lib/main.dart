import 'package:flutter/material.dart';
import 'package:vpn_mobile/screens/welcome_screen.dart';
import 'screens/vpn_connection_screen.dart';
import 'screens/server_selection_screen.dart';

void main() {
  runApp(VPNApp());
}

class VPNApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => WelcomeScreen(),
        // Modifikasi ini jika VPNConnectionScreen membutuhkan parameter
        '/vpn_connection': (context) => VPNConnectionScreen(
          country: '', // Ganti dengan nilai yang sesuai
          city: '', negara: '', kota: '', // Ganti dengan nilai yang sesuai
        ),
        '/server_selection': (context) => ServerSelectionScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
