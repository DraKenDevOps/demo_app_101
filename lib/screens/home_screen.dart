import "package:flutter/material.dart";
import "../models/travel_site.dart";
import "../services/api_service.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final List<TravelSite> _travelSites = TravelSite.mockItems;
  final ApiService api = ApiService();

  @override
  void initState() {
    super.initState();
    _loadTravelSite();
  }

  void _loadTravelSite() async {
    if (mounted) {
      // final response = await api.listTravelSite("", null, null, null, null);
      // if (response.status == "success") {
      //   if (response.items != null && response.items!.isNotEmpty) _travelSites = response.items! as List<TravelSite>;
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TravelSite> travelSites = _travelSites;
    return Scaffold(
      // body: Center(child: Text("Home Screen", style: TextStyle(fontSize: 24))),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: travelSites.length,
          itemBuilder: (context, index) {
            final site = travelSites[index];
            return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(image: NetworkImage(site.coverimage), fit: BoxFit.cover),
                  ),
                ),
                title: Text(site.name),
                subtitle: Text(site.detail),
                // trailing: Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     const Icon(Icons.star, color: Colors.amber, size: 16),
                //     Text(site.rating.toString()),
                //   ],
                // ),
              ),
            );
          },
        ),
      ),
    );
  }
}
