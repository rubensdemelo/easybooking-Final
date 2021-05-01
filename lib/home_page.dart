// Copyright (c) 2021 Razeware LLC
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom
// the Software is furnished to do so, subject to the following
// conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// Notwithstanding the foregoing, you may not use, copy, modify,
// merge, publish, distribute, sublicense, create a derivative work,
// and/or sell copies of the Software in any work that is designed,
// intended, or marketed for pedagogical or instructional purposes
// related to programming, coding, application development, or
// information technology. Permission for such use, copying,
// modification, merger, publication, distribution, sublicensing,
// creation of derivative works, or sale is expressly withheld.
//
// This project and source code may use libraries or frameworks
// that are released under various Open-Source licenses. Use of
// those libraries and frameworks are governed by their own
// individual licenses.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
import 'booking.dart';
import 'detail_page.dart';
import 'item_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  final _timeTextController = TextEditingController();
  final _dayTextController = TextEditingController();

  double _guests = 1;
  bool _openAir = false;
  bool _special = false;

  final _paymentOptions = ['Cash', 'Credit Card'];
  String _paymentChoice = 'Cash';
  final _menuList = [
    ItemMenu('Scallops', false),
    ItemMenu('Burrata Salad', false),
    ItemMenu('Shrimps', false),
    ItemMenu('Beef Tenderloin', false),
    ItemMenu('Short Ribs', false),
    ItemMenu('Lobster Tail', false),
    ItemMenu('Chocoholic', false),
    ItemMenu('Apple Crumble', false),
  ];

  bool validateDateAndTime() {
    return _timeTextController.text.isNotEmpty ||
        _dayTextController.text.isNotEmpty;
  }

  bool validateMenuList() {
    for (final item in _menuList) {
      if (item.selected == true) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EasyBooking'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              TextFormField(
                controller: _nameTextController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (name) {
                  if ((name?.trim().length ?? 0) < 3) {
                    return 'Invalid name';
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                ],
              ),
              TextFormField(
                controller: _emailTextController,
                validator: (mail) {
                  if ((mail?.contains('@')) == false) {
                    return 'Invalid e-mail';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'E-mail'),
              ),
              TextFormField(
                controller: _phoneTextController,
                validator: (phone) {
                  if (phone!.isEmpty) {
                    return 'Invalid phone';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: _dayTextController,
                    decoration: const InputDecoration(labelText: 'Day'),
                    onTap: () async {
                      final selectedDay = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 7)));
                      if (selectedDay != null) {
                        _dayTextController.text =
                            DateFormat.yMd().format(selectedDay);
                      }
                    },
                  )),
                  const SizedBox(width: 16),
                  Expanded(
                      child: TextFormField(
                    controller: _timeTextController,
                    decoration: const InputDecoration(labelText: 'Time'),
                    onTap: () async {
                      final selectedTime = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      if (selectedTime != null) {
                        _timeTextController.text =
                            DateFormat.Hm().format(DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          selectedTime.hour,
                          selectedTime.minute,
                        ));
                      }
                    },
                  )),
                ],
              ),
              Row(
                children: [
                  Text('Guests: ${_guests.ceil()}'),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Slider(
                      value: _guests,
                      min: 1,
                      max: 8,
                      onChanged: (guestNumber) {
                        setState(() {
                          _guests = guestNumber;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SwitchListTile(
                title: const Text('Open Air'),
                contentPadding: const EdgeInsets.all(0),
                value: _openAir,
                onChanged: (openAirOption) {
                  setState(() {
                    _openAir = openAirOption;
                  });
                },
              ),
              Row(),
              CheckboxListTile(
                title: const Text('Special Occasion'),
                contentPadding: const EdgeInsets.all(0),
                value: _special,
                onChanged: (specialOccasionOption) {
                  setState(() {
                    _special = specialOccasionOption!;
                  });
                },
              ),
              Row(
                children: _paymentOptions
                    .map((option) => Expanded(
                          child: RadioListTile(
                            title: Text(option),
                            value: option,
                            groupValue: _paymentChoice,
                            onChanged: (value) {
                              setState(() {
                                _paymentChoice = value.toString();
                              });
                            },
                          ),
                        ))
                    .toList(),
              ),
              const Divider(),
              const Text('Menu'),
              Wrap(
                runSpacing: 2,
                spacing: 8,
                children: _menuList
                    .map((menuItem) => InputChip(
                          label: Text(menuItem.label),
                          selected: menuItem.selected,
                          showCheckmark: false,
                          onSelected: (selected) {
                            setState(() {
                              menuItem.selected = selected;
                            });
                          },
                        ))
                    .toList(),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        validateDateAndTime() &&
                        validateMenuList()) {
                      final booking = Booking(
                          name: _nameTextController.text,
                          email: _emailTextController.text,
                          phone: _phoneTextController.text,
                          day: _dayTextController.text,
                          time: _timeTextController.text,
                          guests: _guests.ceil().toString(),
                          openAir: _openAir,
                          payment: _paymentChoice,
                          specialOccasion: _special,
                          listItemMenu: _menuList);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailPage(booking: booking)));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid data')));
                    }
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Confirm')),
            ],
          ),
        ),
      ),
    );
  }
}
