import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text("Fantasy"),value: "Fantasy"),
    const DropdownMenuItem(child: Text("Adventure"),value: "Adventure"),
    const DropdownMenuItem(child: Text("Romance"),value: "Romance"),
    const DropdownMenuItem(child: Text("Mystery"),value: "Mystery"),
    const DropdownMenuItem(child: Text("Horror"),value: "Horror"),
    const DropdownMenuItem(child: Text("Thriller"),value: "Thriller"),
    const DropdownMenuItem(child: Text("Action"),value: "Action"),
    const DropdownMenuItem(child: Text("Historical"),value: "Historical"),
    const DropdownMenuItem(child: Text("Science Fiction"),value: "Science Fiction"),
  ];
  return menuItems;
}