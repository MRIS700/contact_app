import 'package:contact_app/pages/new_contact.dart';
import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import 'contact_details.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Home Page (Copy)'),
      ),
      body: ListView.builder(
        itemCount: contactList.length,
        itemBuilder: (context, index){
          final contact = contactList[index];
          return ListTile(
          onTap: () {
            Navigator.pushNamed(context, ContactDetails.routeName, arguments: contact);
          },
          leading: CircleAvatar(
            child: Text(contact.name[0]),
          ),
          title: Text(contact.name),
          subtitle: Text(contact.mobile),
          trailing: IconButton(
          icon: Icon(contact.favorite ? Icons.favorite : Icons.favorite_border, color: Colors.pink,),
          onPressed: () {
          setState((){
          contact.favorite = !contact.favorite;
          });
          },
          ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, NewContactPage.routeName),
        child: const Icon(Icons.add),
      ),
    );
  }
}
