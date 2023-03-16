import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gd_club_app/models/event.dart';
import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/widgets/custom_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class EventEditingScreen extends StatefulWidget {
  static const routeName = '/edit-event';

  @override
  State<EventEditingScreen> createState() => _EventEditingScreenState();
}

class _EventEditingScreenState extends State<EventEditingScreen> {
  DateTime _date = DateTime.now();
  DateTime _time = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  Event _newEvent = Event(
    name: '',
    location: '',
    dateTime: DateTime.now(),
    organizer: null,
    registrations: [],
  );

  void _submitForm() {
    if (_formKey.currentState != null) {
      final bool isValid = _formKey.currentState!.validate();

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
              .updateEvent(_newEvent.id!, _newEvent, _eventImage);
        } else {
          // Otherwise -> Create mode
          Provider.of<Events>(context, listen: false)
              .addEvent(_newEvent, _eventImage);
        }

        Navigator.of(context).pop();
      }
    }
  }

  Future<void> deleteEvent() async {
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
              Navigator.of(context).pop();
            },
            child: const Text('Xác nhận'),
          )
        ],
      ),
    );
  }

  final _imagePicker = ImagePicker();
  File? _eventImage;

  Future<void> _pickImage() async {
    try {
      final pickedImageFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      setState(() {
        _eventImage = File(pickedImageFile!.path);
      });
    } catch (e) {}
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    if (arguments.containsKey('event')) {
      _newEvent = arguments['event'] as Event;
      _date = _newEvent.dateTime;
      _time = _newEvent.dateTime;
    } else if (arguments.containsKey('organizer')) {
      final Organizer organizer = arguments['organizer'] as Organizer;
      _newEvent.organizer = organizer;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      appBar: CustomAppBar(
        actions: [
          if (_newEvent.id != null)
            GestureDetector(
              onTap: () {
                deleteEvent();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red[400],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.06),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Ionicons.trash_bin,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          GestureDetector(
            onTap: () {
              _submitForm();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.purple[400],
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.06),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(
                  Ionicons.checkmark,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    children: [
                      // Images
                      GestureDetector(
                        onTap: () {
                          _pickImage();
                        },
                        behavior: HitTestBehavior.translucent,
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: _eventImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  child: Image.file(
                                    _eventImage!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.06),
                                        blurRadius: 16,
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '+ Thêm hình ảnh',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.06),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
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
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    hintStyle: TextStyle(),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  initialValue: _newEvent.name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '';
                                    }

                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    if (newValue != null) {
                                      _newEvent.name = newValue;
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
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    hintStyle: TextStyle(),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 14,
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
                                          final DateTime? pickedDate =
                                              await showDatePicker(
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
                                              const Icon(
                                                Icons.date_range,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                DateFormat.yMd().format(_date),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
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
                                          final DateTime? pickedTime =
                                              await DatePicker.showTimePicker(
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
                                              const Icon(
                                                Icons.access_time,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              // Text(_timeOfDay.toString().substring(10, 15)),
                                              Text(
                                                DateFormat.Hm().format(_time),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
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
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: Colors.grey[400]!,
                                    ),
                                  ),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: 'Mô tả',
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 12,
                                      ),
                                      hintStyle: TextStyle(),
                                    ),
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    minLines: 1,
                                    maxLines: 100,
                                    initialValue: _newEvent.description,
                                    onSaved: (newValue) {
                                      if (newValue != null) {
                                        _newEvent.description = newValue;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
