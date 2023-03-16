import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gd_club_app/models/user.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/providers/users.dart';
import 'package:gd_club_app/widgets/custom_app_bar.dart';
import 'package:gd_club_app/widgets/shadow_container.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AccountEditingScreen extends StatefulWidget {
  static const routeName = '/edit-account';

  const AccountEditingScreen({super.key});

  @override
  State<AccountEditingScreen> createState() => _AccountEditingScreenState();
}

class _AccountEditingScreenState extends State<AccountEditingScreen> {
  final _imagePicker = ImagePicker();
  File? _userImage;

  final _formKey = GlobalKey<FormState>();

  String _name = '';

  late User user;

  bool _isInit = true;

  Future<void> _pickImage() async {
    try {
      final pickedImageFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      setState(() {
        _userImage = File(pickedImageFile!.path);
      });
    } catch (e) {}
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState != null) {
      final bool isValid = _formKey.currentState!.validate();

      if (isValid) {
        _formKey.currentState!.save();

        final newUser = User(
          id: user.id,
          email: user.email,
          name: _name,
          systemRole: user.systemRole,
        );

        await Provider.of<Users>(context, listen: false)
            .updateUser(user.id, newUser, _userImage, context);

        Navigator.of(context).pop();
      }
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      user = Provider.of<Auth>(context).currentUser!;
      _name = user.name;
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          'Chỉnh sửa tài khoản',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      body: Column(
        children: [
          ShadowContainer(
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
                      child: _userImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              child: Image.file(
                                _userImage!,
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
                              hintText: 'Tên',
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
                            initialValue: _name,
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
                                _name = newValue;
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
          GestureDetector(
            onTap: () {
              _submitForm();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.purple[400],
              ),
              child: const Text(
                'Lưu',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
