import 'package:flutter/material.dart';

import '../database/repository.dart';
import '../widgets/contact_tile.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

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
            var filteredList = value
                .where(
                  (element) => element.fav == true,
                )
                .toList();
            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return contactTile(context, filteredList[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
