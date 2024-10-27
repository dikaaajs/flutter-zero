import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteDetail extends StatelessWidget {
  final String headline;
  final String paragraph;

  const NoteDetail(
      {super.key, required this.headline, required this.paragraph});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          child: Text(
            headline,
            style:
                GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
            margin: EdgeInsets.all(20),
            child: Text(
              paragraph,
              style:
                  GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w400),
            ))
      ],
    );
  }
}
