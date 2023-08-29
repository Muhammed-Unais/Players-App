import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:players_app/controllers/video_folder/access_folder/access_video.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    splashFetch();
    super.initState();
    gotoHomeScreen(context);
  }

  Future<void> splashFetch() async {
    await context.read<VideoFileAccessFromStorage>().splashFetch();
  }

  // spalsh duration function
  Future<void> gotoHomeScreen(BuildContext context) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    navigateToBottomNavbar();
  }

  void navigateToBottomNavbar() {
    Navigator.pushReplacementNamed(context, 'bottomNavbar');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset("assets/images/Group 3.svg"),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
