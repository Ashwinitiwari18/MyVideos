import 'package:flutter/material.dart';
import 'package:getx_tutorial/constant.dart';
import 'package:getx_tutorial/view/widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  int pageIdx;
  HomeScreen({super.key, this.pageIdx = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.pageIdx == 0) {
          // If on the home page, exit the app on double back press
          DateTime now = DateTime.now();
          if (currentBackPressTime == null ||
              now.difference(currentBackPressTime!) >
                  const Duration(seconds: 2)) {
            currentBackPressTime = now;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Press back again to exit'),
              ),
            );
            return false;
          }
        } else {
          setState(() {
            widget.pageIdx = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (idx) {
              setState(() {
                widget.pageIdx = idx;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: backgroundColor,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.white,
            currentIndex: widget.pageIdx,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    size: 30,
                  ),
                  label: "Search"),
              BottomNavigationBarItem(icon: CustomIcon(), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.message,
                    size: 30,
                  ),
                  label: "Message"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 30,
                  ),
                  label: "Profile"),
            ]),
        body: pages[widget.pageIdx],
      ),
    );
  }
}
