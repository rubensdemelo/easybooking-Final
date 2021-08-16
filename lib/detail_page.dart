import 'package:flutter/material.dart';

import 'booking.dart';

class DetailPage extends StatelessWidget {
  final Booking booking;
  const DetailPage({
    Key? key,
    required this.booking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(booking.name),
            subtitle: const Text('Name'),
          ),
          ListTile(
            title: Text(booking.email),
            subtitle: const Text('E-mail'),
          ),
          ListTile(
            title: Text(booking.phone),
            subtitle: const Text('Phone'),
          ),
          ListTile(
            title: Text(booking.day),
            subtitle: const Text('Day'),
          ),
          ListTile(
            title: Text(booking.time),
            subtitle: const Text('Time'),
          ),
          ListTile(
            title: Text(booking.guests),
            subtitle: const Text('Guests'),
          ),
          ListTile(
            title: const Text('Open Air'),
            trailing: Switch(
              value: booking.openAir,
              onChanged: null,
            ),
          ),
          ListTile(
            title: const Text('Special Occasion'),
            trailing: Checkbox(
              value: booking.specialOccasion,
              onChanged: null,
            ),
          ),
          ListTile(
            title: Text(booking.payment),
            subtitle: const Text('Payment'),
          ),
          ListTile(
            title: const Text('Menu'),
            subtitle: Wrap(
              runSpacing: 2,
              spacing: 8,
              children: booking.listItemMenu
                  .map((menuItem) => InputChip(
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
