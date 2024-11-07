import 'package:flutter/material.dart';

class VPNConnectionScreen extends StatefulWidget {
  final String negara;
  final String kota;

  VPNConnectionScreen({required this.negara, required this.kota, required String country, required String city});

  @override
  _VPNConnectionScreenState createState() => _VPNConnectionScreenState();
}

class _VPNConnectionScreenState extends State<VPNConnectionScreen> {
  late VpnConnection _vpnConnection;
  bool _sedangMemutusKoneksi = false;

  @override
  void initState() {
    super.initState();
    _vpnConnection = VpnConnection();
  }

  Future<void> putuskanVPN() async {
    setState(() {
      _sedangMemutusKoneksi = true;
    });
    await _vpnConnection.putus();
    setState(() {
      _sedangMemutusKoneksi = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Disconnected from ${widget.kota}, ${widget.negara}'),
        duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image (tetap di tempat asal)
          Image.asset(
            'assets/icons/earth_background.png', // Replace with your image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Content in top center
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0), // Adjust padding for top center
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _vpnConnection.statusKoneksi ? "Connected" : "Disconnected",
                  style: TextStyle(color: Colors.lightBlueAccent, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "00:45:57",
                  style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1E2230),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/flags/canada.png'),
                            radius: 18,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.kota}, ${widget.negara}",
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                                Text(
                                  "21.107.235.45", // Kode server atau alamat IP
                                  style: TextStyle(color: Colors.white70, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.signal_cellular_alt_sharp, color: Colors.lightBlueAccent),
                          Icon(Icons.chevron_right, color: Colors.white), // Ikon ">"
                        ],
                      ),
                      SizedBox(height: 16),
                      Divider(color: Colors.white24),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Kontainer untuk Informasi Unduh
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Color(0xFF2A2E48),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.download, color: Colors.lightBlueAccent, size: 18),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Downloaded", style: TextStyle(color: Colors.white70, fontSize: 12)),
                                      Text("19,5 Mb/s", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          // Kontainer untuk Informasi Unggah
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Color(0xFF2A2E48),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.upload, color: Colors.lightBlueAccent, size: 18),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Uploaded", style: TextStyle(color: Colors.white70, fontSize: 12)),
                                      Text("1,5 Mb/s", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Tombol Disconnect rata kanan kiri
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _sedangMemutusKoneksi ? null : putuskanVPN,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1E2230),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: Colors.lightBlueAccent, width: 1.5),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            icon: Icon(Icons.power_settings_new, color: Colors.lightBlueAccent),
                            label: Text("Disconnect", style: TextStyle(color: Colors.white, fontSize: 16)),
                          ),
                        ),
                      ),
                    ],
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

class VpnConnection {
  bool statusKoneksi = true;

  Future<void> putus() async {
    await Future.delayed(Duration(seconds: 1));
    statusKoneksi = false;
  }
}
