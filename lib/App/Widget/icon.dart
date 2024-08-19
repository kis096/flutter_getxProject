import 'package:flutter/material.dart';
import 'package:getx_todo/App/core/values/icons.dart'; // Removed the extra .dart
import 'package:getx_todo/App/core/values/colors.dart';

List<Widget> getIcons() {
  return const [
    Icon(IconData(personIcon, fontFamily: 'MaterialIcons'), color: purple),
    Icon(IconData(workIcon, fontFamily: 'MaterialIcons'), color: pink),
    Icon(IconData(movieIcon, fontFamily: 'MaterialIcons'), color: green),
    Icon(IconData(sportsIcon, fontFamily: 'MaterialIcons'), color: deepPink),
    Icon(IconData(travelIcon, fontFamily: 'MaterialIcons'), color: blue),
    Icon(IconData(shopIcon, fontFamily: 'MaterialIcons'), color: lightBlue),
  ];
}
