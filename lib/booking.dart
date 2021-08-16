import 'item_menu.dart';

class Booking {
  final String name;
  final String email;
  final String phone;
  final String day;
  final String time;
  final String guests;
  final bool openAir;
  final String payment;
  final bool specialOccasion;

  final List<ItemMenu> listItemMenu;

  const Booking(
      {required this.name,
      required this.email,
      required this.phone,
      required this.day,
      required this.time,
      required this.guests,
      required this.openAir,
      required this.payment,
      required this.specialOccasion,
      required this.listItemMenu});
}
