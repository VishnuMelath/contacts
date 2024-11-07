import 'package:contacts/pages/add_update_page.dart';
import 'package:contacts/pages/fav_screen.dart';
import 'package:contacts/pages/home_screen.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  late int selectedIndex;
  List<Widget> screens = [const HomeScreen(), const FavScreen()];
  @override
  void initState() {
    selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddUpdateContactPage(),
              ));
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              label: 'contacts',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'fav')
          ]),
    );
  }
}
