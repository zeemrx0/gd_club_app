import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gd_club_app/providers/event.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventEditScreen extends StatefulWidget {
  static const routeName = '/event-edit-screen';

  @override
  State<EventEditScreen> createState() => _EventEditScreenState();
}

class _EventEditScreenState extends State<EventEditScreen> {
  final _isCreate = true;

  DateTime _date = DateTime.now();
  DateTime _time = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  final _newEvent = Event(
    title: '',
    location: '',
    dateTime: DateTime.now(),
    organizerId: '1',
  );

  void _submitForm() {
    if (_formKey.currentState != null) {
      bool isValid = _formKey.currentState!.validate();

      if (isValid) {
        _formKey.currentState!.save();

        _newEvent.dateTime = DateTime(
          _date.year,
          _date.month,
          _date.day,
          _time.hour,
          _time.minute,
        );

        Provider.of<Events>(context, listen: false).addEvent(_newEvent);

        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isCreate ? 'Tạo sự kiện' : 'Chỉnh sửa sự kiện'),
        actions: [
          IconButton(
            onPressed: () {
              _submitForm();
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: 'Tên sự kiện',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    bottom: 4,
                  ),
                  errorStyle: TextStyle(height: 0),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  }

                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    _newEvent.title = newValue;
                  }
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: 'Địa điểm',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    bottom: 4,
                  ),
                  errorStyle: TextStyle(height: 0),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  }

                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    _newEvent.location = newValue;
                  }
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await DatePicker.showDatePicker(
                          context,
                          currentTime: _date,
                          locale: LocaleType.vi,
                        );

                        setState(() {
                          _date = pickedDate ?? _date;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.date_range),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(DateFormat.yMd().format(_date)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: () async {
                        DateTime? pickedTime = await DatePicker.showTimePicker(
                          context,
                          currentTime: _time,
                          showSecondsColumn: false,
                          locale: LocaleType.vi,
                        );

                        setState(() {
                          _time = pickedTime ?? _time;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time),
                            const SizedBox(
                              width: 8,
                            ),
                            // Text(_timeOfDay.toString().substring(10, 15)),
                            Text(DateFormat.Hm().format(_time)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Mô tả',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                ),
                maxLines: 6,
                onSaved: (newValue) {
                  if (newValue != null) {
                    _newEvent.description = newValue;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
