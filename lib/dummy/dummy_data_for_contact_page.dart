import 'package:flutter/material.dart';

List<String> dummyContactList = [
  "Alexander Christ",
  "Antonio Gavi",
  "Angelo Mercius",
  "Alvin Chipmunk",
  "Allen Thomas",
  "Bobby Zuma",
  "Brian OConner",
  "Bradley James",
  "Belle",
  "Bonnie Jaqualin",
  "Barry",
  "Christopher Anto",
  "Charles Prince",
  "Cameron",
  "Garret Philips",
  "Gabriel",
  "Grady Malin",
  "Sophia Tella",
  "James Rodriguez",
  "Zander Dior",
  "Zachariah"
];

List<dynamic> alphabetsStartByName = dummyContactList.map((e) => e[0]).toSet().toList();