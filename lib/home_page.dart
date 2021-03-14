import 'package:easybooking/booking.dart';
import 'package:easybooking/detail_page.dart';
import 'package:easybooking/item_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
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

  DateTime _day = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
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
    bool isValid = false;
    _menuList.forEach((item) {
      if (item.selected == true) {
        isValid = true;
      }
    });

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EasyBooking'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              TextFormField(
                controller: _nameTextController,
                decoration: InputDecoration(labelText: 'Name'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (name) {
                  if (name!.length < 3) {
                    return "Invalid name";
                  }
                },
              ),
              TextFormField(
                controller: _emailTextController,
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (mail) {
                  if (!mail!.contains('@')) {
                    return "Invalid e-mail";
                  }
                },
              ),
              TextFormField(
                controller: _phoneTextController,
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (phone) {
                  if (phone!.isEmpty) {
                    return "Invalid phone";
                  }
                },
              ),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _dayTextController,
                    decoration: InputDecoration(labelText: 'Day'),
                    onTap: () async {
                      final selectDay = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 7)));
                      if (selectDay != null) {
                        _day = selectDay;
                        _dayTextController.text =
                            DateFormat.yMd().format(selectDay);
                      }
                    },
                  )),
                  SizedBox(width: 16),
                  Expanded(
                      child: TextFormField(
                    controller: _timeTextController,
                    decoration: InputDecoration(labelText: 'Time'),
                    onTap: () async {
                      final selectedTime = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());

                      if (selectedTime != null) {
                        _time = selectedTime;
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
                  SizedBox(width: 16),
                  Expanded(
                    child: Slider(
                        value: _guests,
                        min: 1,
                        max: 8,
                        onChanged: (value) {
                          setState(() {
                            _guests = value;
                          });
                        }),
                  ),
                ],
              ),
              SwitchListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text('Open air'),
                  value: _openAir,
                  onChanged: (value) {
                    setState(() {
                      _openAir = value;
                    });
                  }),
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
              CheckboxListTile(
                  title: Text('Special Occasion'),
                  value: _special,
                  onChanged: (value) {
                    setState(() {
                      _special = value!;
                    });
                  }),
              Divider(),
              Text('Menu'),
              Wrap(
                runSpacing: 2,
                spacing: 8,
                children: _menuList
                    .map((menuItem) => InputChip(
                          key: Key(menuItem.label.toString()),
                          label: Text(menuItem.label),
                          selected: menuItem.selected,
                          onSelected: (selected) {
                            setState(() {
                              menuItem.selected = selected;
                            });
                          },
                        ))
                    .toList(),
              ),
              SizedBox(height: 24),
              ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        validateDateAndTime() &&
                        validateMenuList()) {
                      final booking = Booking(
                          _nameTextController.text,
                          _emailTextController.text,
                          _phoneTextController.text,
                          _day,
                          _time,
                          _guests,
                          _openAir,
                          _paymentChoice,
                          _special,
                          _menuList);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailPage(booking)));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Invalid data')));
                    }
                  },
                  icon: Icon(Icons.check),
                  label: Text('Confirm')),
            ],
          ),
        ),
      ),
    );
  }
}
