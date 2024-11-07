import 'package:flutter/material.dart';
import 'vpn_connection_screen.dart'; // Pastikan ini diimpor

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0D0D0D),
        primaryColor: Colors.blue,
      ),
      home: ServerSelectionScreen(),
    );
  }
}

class ServerSelectionScreen extends StatefulWidget {
  @override
  _ServerSelectionScreenState createState() => _ServerSelectionScreenState();
}

class _ServerSelectionScreenState extends State<ServerSelectionScreen> {
  bool autoSelection = true;
  String selectedTab = 'Global';

  // Daftar server untuk setiap tab
  List<Map<String, dynamic>> globalServers = [
    {'country': 'Canada', 'city': 'Toronto', 'flag': 'assets/flags/canada.png', 'selected': false},
    {'country': 'France', 'city': 'Paris', 'flag': 'assets/flags/france.png', 'selected': false},
    {'country': 'Japan', 'city': 'Tokyo', 'flag': 'assets/flags/japan.png', 'selected': false},
    {'country': 'Estonia', 'city': 'Tallinn', 'flag': 'assets/flags/estonia.png', 'selected': false},
    {'country': 'Italy', 'city': 'Milan', 'flag': 'assets/flags/italy.png', 'selected': false},
  ];

  List<Map<String, dynamic>> specialServers = [
    {'country': 'France', 'city': 'Paris', 'flag': 'assets/flags/france.png', 'selected': false},
    {'country': 'Japan', 'city': 'Tokyo', 'flag': 'assets/flags/japan.png', 'selected': false},
  ];

  List<Map<String, dynamic>> selectedServers = [];

  List<Map<String, dynamic>> get currentServers {
    if (selectedTab == 'Global') return globalServers;
    if (selectedTab == 'Special') return specialServers;
    return selectedServers;
  }

  void toggleFavorite(int index) {
    setState(() {
      currentServers[index]['selected'] = !currentServers[index]['selected'];
      if (currentServers[index]['selected'] && !selectedServers.contains(currentServers[index])) {
        selectedServers.add(currentServers[index]);
      } else if (!currentServers[index]['selected']) {
        selectedServers.remove(currentServers[index]);
      }
    });
  }

  void connectToServer(String country, String city) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VPNConnectionScreen(negara: country, kota: city, country: '', city: '',),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select servers', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF1B1B1B),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchField(),
            SizedBox(height: 15),
            _buildTabSelection(),
            SizedBox(height: 15),
            _buildAutoSelectionToggle(),
            SizedBox(height: 10),
            Divider(color: Colors.grey[700]),
            SizedBox(height: 10),
            Text(
              'Select Servers',
              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: _buildServerList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.blue),
        hintText: 'Search',
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor: Color(0xFF2C2C2E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildTabSelection() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTabButton('Global'),
          _buildTabButton('Special'),
          _buildTabButton('Selected'),
        ],
      ),
    );
  }

  Widget _buildTabButton(String tabName) {
    bool isSelected = selectedTab == tabName;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = tabName;
          });
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: isSelected
                ? BorderRadius.circular(8)
                : BorderRadius.circular(0),
          ),
          child: Text(
            tabName,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.white : Colors.grey[400],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAutoSelectionToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.autorenew, color: Colors.grey[400]), // Icon sebelah Auto Selection
            SizedBox(width: 10),
            Text(
              'Auto Selection',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            autoSelection ? Icons.toggle_on : Icons.toggle_off,
            color: autoSelection ? Colors.blue : Colors.grey[500],
            size: 40,
          ),
          onPressed: () {
            setState(() {
              autoSelection = !autoSelection;
            });
          },
        ),
      ],
    );
  }

  Widget _buildServerList() {
    return ListView.builder(
      itemCount: currentServers.length,
      itemBuilder: (context, index) {
        return _buildServerTile(
          currentServers[index]['country'],
          currentServers[index]['city'],
          currentServers[index]['flag'],
          currentServers[index]['selected'],
          index,
        );
      },
    );
  }

  Widget _buildServerTile(String country, String city, String flag, bool isSelected, int index) {
    return GestureDetector(
      onTap: () {
        toggleFavorite(index);
        if (country == 'Canada') {
          connectToServer(country, city); // Navigasi hanya untuk Kanada
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.15) : Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 16,
            backgroundColor: Colors.transparent,
            child: Image.asset(
              flag,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.flag, color: Colors.grey);
              },
            ),
          ),
          title: Text(
            country,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          subtitle: Text(
            city,
            style: TextStyle(color: Colors.grey[500], fontSize: 13),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.signal_cellular_alt, color: Colors.blue),
              SizedBox(width: 10),
              Icon(
                isSelected ? Icons.star : Icons.star_border,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
