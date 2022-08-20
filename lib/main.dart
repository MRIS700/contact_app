import 'package:contact_app/pages/contact_details.dart';
import 'package:contact_app/pages/home_page.dart';
import 'package:contact_app/pages/new_contact.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName : (context) => const HomePage(),
        NewContactPage.routeName : (context) => const NewContactPage(),
        ContactDetails.routeName : (context) => const ContactDetails(),
      },
    );
  }
}

