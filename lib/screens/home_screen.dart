import "package:flutter/material.dart";
import "../services/api_service.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  // final List<dynamic> _travelSite = [];
  final ApiService api = ApiService();
  
  @override
  void initState() {
    super.initState();
    _loadTravelSite();
  }

  void _loadTravelSite() async {
    if (mounted) {
      await api.listTravelSite("", null, null, null, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    // List<dynamic> travelSite = [];
    return const Scaffold(
      body: Center(child: Text("Home Screen", style: TextStyle(fontSize: 24))),
    );
  }
}
