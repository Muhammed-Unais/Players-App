import 'package:flutter/material.dart';
import 'package:domedia/controllers/video_folder/access_folder/access_video.dart';
import 'package:flutter/services.dart';
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

  Future<void> gotoHomeScreen(BuildContext context) async {
    await Future.delayed(
      const Duration(seconds: 4),
    );
    navigateToBottomNavbar();
  }

  void navigateToBottomNavbar() {
    Navigator.pushReplacementNamed(context, 'bottomNavbar');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: Center(
        child: Image.asset(
          color: Colors.black,
          "assets/images/domedia_icon.png",
          height: 100,
          width: 100,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
