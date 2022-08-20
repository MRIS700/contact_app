import 'dart:io';

import 'package:contact_app/db/db_helper.dart';
import 'package:contact_app/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName = '/new_contact';

  const NewContactPage({Key? key}) : super(key: key);

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  String? _dob;
  String? _genderGroupValue;
  String? _imagePath;
  ImageSource _imageSource = ImageSource.camera;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
        actions: [
          IconButton(
              onPressed: _saveContact, icon: const Icon(Icons.done_rounded))
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter a Valid Name';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Contact Name',
                filled: true,
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              keyboardAppearance: Brightness.light,
              controller: _mobileController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter a Valid Mobile Number';
                }
                if (value.length < 11 || value.length > 14) {
                  return 'Enter Valid Number!';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                filled: true,
                prefixIcon: Icon(Icons.phone_android),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                filled: true,
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                filled: true,
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: _selectDate,
                      child: const Text('Select Date of Birth')),
                  Chip(label: Text(_dob == null ? 'No Date Selected' : _dob!))
                ],
              ),
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Select Gender'),
                  Radio<String>(
                      value: 'Male',
                      groupValue: _genderGroupValue,
                      onChanged: (value) {
                        setState(() {
                          _genderGroupValue = value;
                        });
                      }),
                  const Text('Male'),
                  Radio<String>(
                      value: 'Female',
                      groupValue: _genderGroupValue,
                      onChanged: (value) {
                        setState(() {
                          _genderGroupValue = value;
                        });
                      }),
                  const Text('Female'),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    elevation: 5,
                    child: _imagePath == null
                        ? Image.asset(
                      'images/contact_image.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                        : Image.file(
                      File(_imagePath!),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            _imageSource = ImageSource.camera;
                            _getImage();
                          },
                          icon: const Icon(Icons.camera),
                          label: const Text('Capture')),
                      TextButton.icon(
                          onPressed: () {
                            _imageSource = ImageSource.gallery;
                            _getImage();
                          },
                          icon: const Icon(Icons.photo_album),
                          label: const Text('Gallery'))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _saveContact() async{
    /*if (_dob == null){
      ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text('Please Slecet DoB!')));
      return;
    } */
    if (_formKey.currentState!.validate()) {
      final contact = ContactModel(
          name: _nameController.text,
          mobile: _mobileController.text,
          email: _emailController.text,
          streetAddress: _addressController.text,
          dob: _dob,
          gender: _genderGroupValue,
          image: _imagePath,
      );
      final rowId = await DBHelper.insertContact(contact);
      if(rowId > 0){
        //if (!mounted) return;
        //Navigator.of(context).pop();
        Navigator.pop(context);
      } else {
        //Show error message
        //ScaffoldMessenger.of(context)
        //    .showSnackBar(const SnackBar(content: Text('Please Select DoB!')));
      }
    }
  }

  void _selectDate() async{
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1901),
        lastDate: DateTime.now());
    if (selectedDate != null) {
      setState(() {
        _dob = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  void _getImage() async {
    final selectedImage = await ImagePicker().pickImage(
        source: _imageSource, maxHeight: 100, maxWidth: 100);
    if (selectedImage != null) {
      setState(() {
        _imagePath = selectedImage.path;
      });
    }
  }
}
