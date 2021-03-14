import 'package:easybooking/item_menu.dart';
import 'package:flutter/material.dart';

class Booking {
  String name;
  String email;
  String phone;
  DateTime day;
  TimeOfDay time;
  double guests;
  bool openAir;
  String payment;
  bool specialOccasion;

  List<ItemMenu> listItemMenu;

  Booking(this.name, this.email, this.phone, this.day, this.time, this.guests,
      this.openAir, this.payment, this.specialOccasion, this.listItemMenu);
}
