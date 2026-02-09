import 'package:cmpdiri4/features/dashboard/screens/user_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../auth/providers/auth_provider.dart';
import '../auth/screens/welcome_screen.dart';
import '../dashboard/screens/admin_dashboard_screen.dart';
import '../vehicles/providers/vehicle_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late VideoPlayerController _controller;
  bool _isDataLoaded = false;
  bool _navigationCalled = false;

  @override
  void initState() {
    super.initState();

    // 1. Initialize and play the video
    _controller = VideoPlayerController.asset('assets/splash_video.mp4')
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {});
        _controller.play();
        _controller.addListener(_tryNavigate);
      });

    // 2. Pre-load data (ref.read is safe in initState)
    ref.read(vehicleListProvider.future).then((_) {
      if (mounted) {
        setState(() {
          _isDataLoaded = true;
        });
      }
      _tryNavigate();
    });
  }

  void _tryNavigate() {
    if (!mounted || _navigationCalled) return;

    final videoFinished = _controller.value.isInitialized &&
        _controller.value.position >= _controller.value.duration;

    if (!videoFinished || !_isDataLoaded) return;

    final authState = ref.read(authControllerProvider);

    authState.whenOrNull(
      authenticated: (user) {
        _navigationCalled = true;
        if (user.role == 'admin') {
          Navigator.of(context).pushReplacement(AdminDashboardScreen.route());
        } else {
          Navigator.of(context).pushReplacement(UserDashboardScreen.route());
        }
      },
      unauthenticated: (_) {
        _navigationCalled = true;
        Navigator.of(context).pushReplacement(WelcomeScreen.route());
      },
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_tryNavigate);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 3. Listen for authentication changes to handle navigation correctly.
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      _tryNavigate();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
