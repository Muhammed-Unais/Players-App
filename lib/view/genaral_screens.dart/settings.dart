import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:players_app/controllers/song_folder/page_manager.dart';
import 'package:players_app/controllers/resetpp.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:players_app/view/genaral_screens.dart/splashscreen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> settingsName = [
      'About Us',
      'ResetApp',
      'Privacy and Policy',
      'Terms and Conditions',
    ];
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "SETTINGS",
          style: GoogleFonts.raleway(
              fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: settingsName.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: 6, left: 20, right: 20, top: 6),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                           if (index == 0) {
                            return  AboutusScreen(fileName: "about_us.md",);
                          }
                          if (index == 1) {
                            return const RestApp();
                          }
                          if (index == 3) {
                            return AboutusScreen(
                              fileName: "terms_and_conditions.md",
                            );
                          }
                          return AboutusScreen(
                            fileName: "privacy_policy.md",
                          );
                        },
                      );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 12,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(left: 20),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(),
                        ],
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          settingsName[index],
                          style: GoogleFonts.raleway(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Text(
              "Version 1.1.0",
              style: GoogleFonts.raleway(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutusScreen extends StatelessWidget {
  final double radius;
  final String fileName;
  AboutusScreen({super.key, this.radius = 8, required this.fileName})
      : assert(fileName.contains('.md'),
            'The file must contain the .md extension');

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(const Duration(milliseconds: 150)).then(
                (value) {
                  return rootBundle.loadString("assets/$fileName");
                },
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Markdown(data: snapshot.data ?? "");
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              backgroundColor: const MaterialStatePropertyAll(
                Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Close"),
          )
        ],
      ),
    );
  }
}

class RestApp extends StatelessWidget {
  const RestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      title: Text(
        "ResetApp",
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      content: Text(
        "Are you sure you want to reset the App?",
        style: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "NO",
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            ResetApp.resetApp();
            PageManger.audioPlayer.stop();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return const SplashScreen();
              },
            ), (route) => false);
          },
          child: Text(
            "Yes",
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
