import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image (tetap di tempat asal)
          Image.asset(
            'assets/icons/background.png', // Ganti dengan path gambar Anda
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Content text and button positioned together at the top left
          Padding(
            padding: const EdgeInsets.only(top: 100.0, left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Trusted servers\nwith one tap",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16), // Jarak antara teks dan tombol
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the VPN Connection Screen
                    Navigator.pushNamed(context, '/server_selection');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    minimumSize: const Size.fromHeight(50), // Full width button
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
