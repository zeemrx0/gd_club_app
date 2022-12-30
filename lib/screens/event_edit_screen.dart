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
  DateTime _date = DateTime.now();
  DateTime _time = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  Event _newEvent = Event(
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

        if (_newEvent.id != null) {
          // New event's id exist -> Edit mode
          Provider.of<Events>(context, listen: false)
              .updateEvent(_newEvent.id!, _newEvent);
        } else {
          // Otherwise -> Create mode
          Provider.of<Events>(context, listen: false).addEvent(_newEvent);
        }

        Navigator.of(context).pop();
      }
    }
  }

  void deleteEvent() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xóa sự kiện'),
        content: const Text('Bạn chắc chắn muốn xóa sự kiện này?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<Events>(context, listen: false)
                  .deleteEvent(_newEvent.id!);
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Xác nhận'),
          )
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      _newEvent = ModalRoute.of(context)!.settings.arguments as Event;
      _date = _newEvent.dateTime;
      _time = _newEvent.dateTime;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_newEvent.id == null ? 'Tạo sự kiện' : 'Chỉnh sửa sự kiện'),
        actions: [
          if (_newEvent.id != null)
            IconButton(
              onPressed: () {
                deleteEvent();
              },
              icon: const Icon(Icons.delete_forever),
            ),
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
                initialValue: _newEvent.title,
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
                initialValue: _newEvent.location,
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
                        // DateTime? pickedDate = await DatePicker.showDatePicker(
                        //   context,
                        //   currentTime: _date,
                        //   locale: LocaleType.vi,
                        // );

                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _date,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030, 12, 31),
                          locale: const Locale('vi'),
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
                initialValue: _newEvent.description,
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
