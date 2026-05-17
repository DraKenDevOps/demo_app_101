// import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";

import "../utils/helpers.dart";
import "../models/user_model.dart";
import "../services/storage_service.dart";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    UserModel? user = await StorageService.getUser();
    if (mounted) {
      setState(() {
        _user = user;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_user == null) return const Scaffold(body: Center(child: Text("No user data")));
    UserModel user = _user!;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[300]),
              child: ClipOval(
                // child: CachedNetworkImage(
                //   imageUrl: user.avatar,
                //   placeholder: (context, url) => CircularProgressIndicator(),
                //   errorWidget: (context, url, error) => const Icon(Icons.person, size: 60)
                // ),
                child: Image.network(
                  user.avatar,
                  fit: BoxFit.cover,
                  // headers: {"Accept":"image/*","User-Agent":"DemoApp101/1.0"},
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return CircularProgressIndicator();
                  },
                  webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 60),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(user.fullName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("@${user.username}", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            const SizedBox(height: 32),
            _buildInfoCard(context, "Email", user.email, Icons.email),
            // _buildInfoCard(context, "Username", user.username, Icons.person),
            // _buildInfoCard(context, "ID", user.id.toString(), Icons.tag),
            _buildInfoCard(context, "Created", formatDateTime(user.createdAt), Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String label, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: .3,
      child: ListTile(leading: Icon(icon), title: Text(label), subtitle: Text(value)),
    );
  }
}
