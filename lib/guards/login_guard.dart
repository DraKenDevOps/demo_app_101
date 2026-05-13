import "package:flutter/material.dart";
import "../services/storage_service.dart";

class LoginGuard extends StatefulWidget {
  final Widget child;

  const LoginGuard({super.key, required this.child});

  @override
  State<LoginGuard> createState() => _LoginGuardState();
}

class _LoginGuardState extends State<LoginGuard> {
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final hasToken = await StorageService.hasToken();
    if (mounted) {
      setState(() {
        _isLoggedIn = hasToken;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed("/");
      });
      return const SizedBox.shrink();
    }

    return widget.child;
  }
}