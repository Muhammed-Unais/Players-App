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
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.4))),
      height: hight * 0.07,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16),
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
              child: Container(
                margin:const EdgeInsets.only(right: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                    colors: [Colors.grey[500]!, Colors.white24],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 0.1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
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
          );
        },
      ),
    );
  }
}
