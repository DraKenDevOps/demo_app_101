// import "package:flutter/foundation.dart";
import "dart:convert";

import "package:flutter/material.dart";
import "../models/travel_site.dart";
// import "../services/api_service.dart";

class DetailScreen extends StatefulWidget {
  final int id;
  const DetailScreen({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _DetailScreen();
}

class _DetailScreen extends State<DetailScreen> {
  final List<TravelSite> _travelSites = TravelSite.mockItems;
  late TravelSite travelSite;
  @override
  void initState() {
    super.initState();
    _loadTravelSite();
  }

  void _loadTravelSite() {
    if (mounted) {
      travelSite = _travelSites.firstWhere((item) => item.id == widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(jsonEncode(travelSite)),
    );
  }
}
