import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gd_club_app/models/account.dart';
import 'package:gd_club_app/models/team.dart';
import 'package:gd_club_app/models/user.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/providers/teams.dart';
import 'package:gd_club_app/widgets/custom_app_bar.dart';
import 'package:gd_club_app/widgets/shadow_container.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class EditTeamScreen extends StatefulWidget {
  static const routeName = '/edit-team';

  const EditTeamScreen({super.key});

  @override
  State<EditTeamScreen> createState() => _EditTeamScreenState();
}

class _EditTeamScreenState extends State<EditTeamScreen> {
  final _imagePicker = ImagePicker();
  File? _teamImage;

  Team _newTeam = Team('', '', '');

  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    try {
      final pickedImageFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      setState(() {
        _teamImage = File(pickedImageFile!.path);
      });
    } catch (e) {}
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState != null) {
      final bool isValid = _formKey.currentState!.validate();

      if (isValid) {
        _formKey.currentState!.save();

        print(_newTeam.name);

        final User user =
            Provider.of<Auth>(context, listen: false).account as User;

        await user.createATeam(_newTeam, _teamImage, context);

        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      appBar: CustomAppBar(
        actions: [
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
      body: ShadowContainer(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                _pickImage();
              },
              behavior: HitTestBehavior.translucent,
              child: SizedBox(
                width: 120,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: _teamImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          child: Image.file(
                            _teamImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              '+ Thêm hình ảnh',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: 'Tên đội nhóm',
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
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }

                          return null;
                        },
                        onSaved: (newValue) {
                          if (newValue != null) {
                            _newTeam.name = newValue;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: 'Mô tả',
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
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }

                          return null;
                        },
                        onSaved: (newValue) {
                          if (newValue != null) {
                            _newTeam.description = newValue;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
