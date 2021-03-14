import 'package:easybooking/booking.dart';
import 'package:easybooking/item_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  final Booking booking;

  const DetailPage(this.booking);

  @override
  Widget build(BuildContext context) {
    var selectedItems = <ItemMenu>[];
    booking.listItemMenu.forEach((itemMenu) {
      if (itemMenu.selected) selectedItems.add(itemMenu);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(booking.name),
            subtitle: Text('Name'),
          ),
          ListTile(
            title: Text(booking.email),
            subtitle: Text('E-mail'),
          ),
          ListTile(
            title: Text(booking.phone),
            subtitle: Text('Phone'),
          ),
          ListTile(
            title: Text(DateFormat.yMd().format(booking.day)),
            subtitle: Text('Day'),
          ),
          ListTile(
            title: Text(DateFormat.Hm().format(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              booking.time.hour,
              booking.time.minute,
            ))),
            subtitle: Text('Time'),
          ),
          ListTile(
            title: Text(booking.guests.ceil().toString()),
            subtitle: Text('Guests'),
          ),
          ListTile(
            title: Text('Open air'),
            trailing: Checkbox(
              value: booking.openAir,
              onChanged: null,
            ),
          ),
          ListTile(
            title: Text(booking.payment),
            subtitle: Text('Payment'),
          ),
          ListTile(
            title: Text('Special Occasion'),
            trailing: Checkbox(
              value: booking.specialOccasion,
              onChanged: null,
            ),
          ),
          ListTile(
            title: Text('Menu'),
            subtitle: Wrap(
              runSpacing: 2,
              spacing: 8,
              children: selectedItems
                  .map((menuItem) => InputChip(
                        key: Key(menuItem.label.toString()),
                        label: Text(menuItem.label),
                        selected: menuItem.selected,
                        onSelected: null,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
