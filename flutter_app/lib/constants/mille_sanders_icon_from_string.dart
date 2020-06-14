import 'package:flutter/material.dart';
import 'package:growthdeck/constants/mille_sanders_icons.dart';

IconData milleSandersIconFrom(String icon) {
  switch (icon) {
    case 'arrowleft':
      return MilleSanders.arrowleft;
    case 'arrowright':
      return MilleSanders.arrowright;
    case 'business':
      return MilleSanders.business;
    case 'dollar':
      return MilleSanders.dollar;
    case 'noun_business_idea':
      return MilleSanders.noun_business_idea;
    case 'business':
      return MilleSanders.business;
    case 'advice':
      return MilleSanders.advice;
    default:
      return MilleSanders.advice;
  }
}
