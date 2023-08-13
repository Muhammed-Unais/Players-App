import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouriteAndPlaylistButton extends StatelessWidget {
  const FavouriteAndPlaylistButton({
    super.key,
    required this.hight,
    required this.navigateScreen,
    required this.width,
    required this.items,
    required this.icons,
  });

  final double hight;
  final List<Widget> navigateScreen;
  final double width;
  final List items;
  final List<Widget> icons;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey,width: 0.2))
      ),
      height: hight * 0.07,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return navigateScreen[index];
                    },
                  ),
                );
              },
              child: Card(
                elevation: 0.1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white70,
                child: SizedBox(
                  height: 36,
                  width: width * 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        items[index],
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      icons[index]
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}