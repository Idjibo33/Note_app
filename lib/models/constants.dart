import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//la classe de Styles
class Styles {
  //la couleur primaire
  static const Color primaryColor = Colors.teal;

  // le style de hintText pour les textfields
  static const TextStyle hintText = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.w500,
  );

  //Le style de texte pour les titres
  static TextStyle titreTexte = GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  //Le style de texte pour les textes de corps
  static TextStyle corpsTexte = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );
}
