import 'package:contacts/database/repository.dart';
import 'package:contacts/widgets/contact_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contacts'),
        ),
        body: ValueListenableBuilder(
          valueListenable: CrudOperatons.contacts,
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                return contactTile(context, value[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
