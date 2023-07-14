import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../views/category.dart';

class CategoryTile extends StatelessWidget {
  final VoidCallback onTap;
  final String imageURL, categoryName;
  final Color color;

  CategoryTile(
      {required this.imageURL,
      required this.categoryName,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 157,
        width: 128,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
                image: NetworkImage(imageURL), fit: BoxFit.cover)),
        margin: EdgeInsets.only(right: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              categoryName,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
