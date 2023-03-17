import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:players_app/controllers/get_all_songsfunctioms.dart';
import 'package:players_app/controllers/functions/resetpp.dart';
import 'package:players_app/model/settingsmodel.dart';
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
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "SETTINGS",
          style: GoogleFonts.raleway(
              fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black),
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
                      index == 1
                          ? showDialog(
                              context: context,
                              builder: (context) {
                                return const ShowDialouge();
                              },
                            )
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return AboutusScreen(
                                    headings: settingsName[index],
                                    para: SettingsModel.innerContent[index],
                                  );
                                },
                              ),
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
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Text(
              "Version 1.0.2",
              style: GoogleFonts.raleway(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutusScreen extends StatelessWidget {
  final String headings;
  final String para;
  const AboutusScreen({super.key, required this.headings, required this.para});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(headings),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                para,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowDialouge extends StatelessWidget {
  const ShowDialouge({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
