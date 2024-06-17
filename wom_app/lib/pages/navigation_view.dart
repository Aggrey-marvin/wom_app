import 'package:flutter/material.dart';
import 'package:wom_app/pages/bluetooth/bluetooth_scan.dart';
import 'package:wom_app/pages/home_page.dart';
import 'package:wom_app/pages/profile_page.dart';
import 'dart:convert'; // For base64 decoding
import 'dart:typed_data';


class NavigatorView extends StatefulWidget {
  final dynamic response;
  final dynamic sessionData;
  const NavigatorView({super.key, required this.response, required this.sessionData});

  @override
  State<NavigatorView> createState() => _NavigatorViewState();
}

class _NavigatorViewState extends State<NavigatorView> {
  PageController pageController = PageController();
  late List<Widget> _pages;



  @override
  void initState() {
    super.initState();
      String base64Image = widget.response['data']['photo'] as String;
      Uint8List imageBytes = base64Decode(base64Image);
      String name = widget.response['data']['name'];
    String password = widget.response['password'];

    print('This is the password One : $password');


      _pages = <Widget>[
        Home(
          image: imageBytes, name: name,
        ),
        BlueScan(exercises: widget.response['exercises'], response: widget.response, sessionData: widget.sessionData),
        Profile(
          response: widget.response, sessionData: widget.sessionData,
        ),
      ];


  }

  int _selectedTab = 0;
  _changePage(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  void _onItemTap(int selectedItems) {
    pageController.jumpToPage(selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    Widget foreground = PageView(
      controller: pageController,
      onPageChanged: _changePage,
      children: _pages,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Wearable Knee Monitor"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Colors.cyan[900],
          fontSize: 24,
        ),
      ),
      body: Stack(
        children: [
          foreground,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTap,
        currentIndex: _selectedTab,
        selectedItemColor: Colors.cyan[900],
        // unselectedItemColor: Colors.black,
        backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
        iconSize: 35,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _selectedTab == 0 ? Colors.cyan[900] : Colors.black,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fitness_center,
              color: _selectedTab == 1 ? Colors.cyan[900] : Colors.black,
            ),
            label: 'Exercise',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _selectedTab == 2 ? Colors.cyan[900] : Colors.black,
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
