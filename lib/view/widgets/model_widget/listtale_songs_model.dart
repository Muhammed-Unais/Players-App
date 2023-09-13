import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListtaleModelVidSong extends StatelessWidget {
  final void Function() onTap;
  final Widget leading;
  final String title;
  final String? subtitle;
  final Widget? trailingOne;
  final Widget? trailingTwo;
  const ListtaleModelVidSong(
      {super.key,
      required this.onTap,
      required this.leading,
      required this.title,
      this.subtitle,
      this.trailingOne,
      this.trailingTwo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        style: GoogleFonts.raleway(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Text(
        subtitle == null ? "" : subtitle!,
        style: GoogleFonts.raleway(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          trailingOne == null ? const SizedBox() : trailingOne!,
          trailingTwo == null ? const SizedBox() : trailingTwo!
        ],
      ),
    );
  }
}
