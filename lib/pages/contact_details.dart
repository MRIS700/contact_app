import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/contact_model.dart';

class ContactDetails extends StatefulWidget {
  static const String routeName = '/details';

  const ContactDetails({Key? key}) : super(key: key);

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  late ContactModel contact;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    contact = ModalRoute.of(context)!.settings.arguments as ContactModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                contact.image == null
                    ? Image.asset(
                  'images/contact_image.png',
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                )
                    : Image.file(
                  File(contact.image!),
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                ListTile(
                  title: Text(contact.mobile),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: _callContact, icon: const Icon(Icons.call)),
                      IconButton(onPressed: _smsContact, icon: const Icon(Icons.sms))
                    ],
                  ),
                ),
                ListTile(
                  title: Text(contact.email ?? 'Unavailable'),
                  trailing: IconButton(
                      onPressed: contact.email == null ? null : _mailContact,
                      icon: const Icon(Icons.email)),
                ),
                ListTile(
                  title: Text(contact.streetAddress ?? 'Address Unavailable'),
                  trailing: IconButton(
                      onPressed: contact.streetAddress == null ? null : _mapContact,
                      icon: const Icon(Icons.location_on)),
                ),
                ListTile(
                  title: Text(contact.dob ?? 'DoB Unavailable'),
                  trailing: IconButton(
                      onPressed: contact.dob == null ? null : () {},
                      icon: const Icon(Icons.calendar_month)),
                )
              ],
            ),
          ),
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.only(left: 0, right: 0, bottom: 8),
            child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit, color: Colors.white,)),
                    const Text('Edit', style: TextStyle(color: Colors.white),),
                  ],
                ),
                Column(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.share, color: Colors.white,)),
                    const Text('Share', style: TextStyle(color: Colors.white),),
                  ],
                ),
                Column(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.block, color: Colors.white,)),
                    const Text('Block', style: TextStyle(color: Colors.white),),
                  ],
                )
              ],
            ),
          )
        ],
      ),

    );
  }

  void _callContact() async{
    String url = 'tel:${contact.mobile}';
    bool status = await canLaunchUrl(Uri.parse(url));
    if(status){
      launchUrl(Uri.parse(url));
    } else {
      throw 'Unable to Manage Phone Call App';
    }
  } // Call

  void _smsContact () async{
    String url = 'sms:${contact.mobile}';
    bool status = await canLaunchUrl(Uri.parse(url));
    if(status){
      launchUrl(Uri.parse(url));
    } else {
      'Unable to Manage SMS App';
    }
  } // SMS

  void _mailContact () async{
    String url = 'mailto:${contact.email}?';
    bool status = await canLaunchUrl(Uri.parse(url));
    if(status){
      launchUrl(Uri.parse(url));
    } else {
      'Please Check You Have An Email App';
    }
  } // Mail
  void _mapContact () async {
    String url = 'geo:0,0?q=${contact.streetAddress}';
    bool status = await canLaunchUrl(Uri.parse(url));
    if(status){
      launchUrl(Uri.parse(url));
    } else {
      'Unable to Open Map!';
    }
  } // Map
}
