// import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "../screens/detail_screen.dart";
import "../providers/travel_site.dart";
import "../models/travel_site.dart";
import "../services/api_service.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final List<TravelSite> _travelSites = TravelSiteProvider.mockItems;
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

  // void _viewDetail(int id) {
  //   if (kDebugMode) {
  //     print("tab id $id");
  //   }
  // }

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
              margin: EdgeInsets.fromLTRB(16,8,16,8),
              elevation: .5,
              child: ListTile(
                leading: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Image.network(
                    site.coverimage,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CircularProgressIndicator();
                    },
                    webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 60),
                  ),
                ),
                title: Text(site.name),
                subtitle: Text(site.detail, overflow: TextOverflow.ellipsis, maxLines: 2, softWrap: false),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(id: site.id)));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
