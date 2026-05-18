import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "../providers/travel_site.dart";
import "../utils/helpers.dart";
import "../theme.dart";
import "../models/travel_site.dart";
// import "../services/api_service.dart";

class DetailScreen extends StatefulWidget {
  final int id;
  const DetailScreen({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _DetailScreen();
}

class _DetailScreen extends State<DetailScreen> {
  final List<TravelSite> _travelSites = TravelSiteProvider.mockItems;
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

  void _onViewMap() {
    if (kDebugMode) print("Click view in maps providers: google maps etc.");
  }

  void _onShare() {
    if (kDebugMode) print("Click share: copylink call build in mobile share api.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                travelSite.name,
                style: const TextStyle(
                  color: AppTheme.surfaceColor,
                  shadows: [Shadow(color: AppTheme.blackColor, blurRadius: 4)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    travelSite.coverimage,
                    fit: BoxFit.cover,
                    webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CircularProgressIndicator();
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: AppTheme.darkTextPrimary, child: const Icon(Icons.image, size: 50)),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(Icons.location_on, "Location", "${travelSite.latitude}, ${travelSite.longitude}"),
                  const SizedBox(height: 16),
                  _buildInfoRow(Icons.calendar_today, "Created", formatDateTime(travelSite.createdAt)),
                  const SizedBox(height: 24),
                  const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    travelSite.detail,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _onViewMap,
                          icon: const Icon(Icons.map),
                          label: const Text("View Map"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _onShare,
                          icon: const Icon(Icons.share),
                          label: const Text("Share"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppTheme.secondaryColor),
        const SizedBox(width: 8),
        Text(
          "$label: ",
          style: TextStyle(fontWeight: FontWeight.w600, color: AppTheme.secondaryColor),
        ),
        Text(value),
      ],
    );
  }
}
