import 'package:flutter/material.dart';
import 'package:flutter_mobile/src/pages/dashboard.dart';
import 'package:flutter_mobile/src/pages/mobilitas.dart';
import 'package:flutter_mobile/src/pages/peminjaman.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  List<Widget> _buildScreens() {
    return [
      Dashboard(),
      Mobilitas(),
      Screen3(),
      Peminjaman(),
      Screen3(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Color(0xff4d87b7),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.flip_camera_android),
        title: ("Mobilitas"),
        activeColorPrimary: Color(0xff4d87b7),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.qr_code,
          color: Colors.white,
        ),
        title: ("Check"),
        activeColorPrimary: Color(0xff4d87b7),
        inactiveColorPrimary: Colors.grey,
        onPressed: (p0) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            headerAnimationLoop: true,
            title: 'Bener',
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.blue,
          ).show();
        },
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.inventory),
        title: ("Peminjaman"),
        activeColorPrimary: Color(0xff4d87b7),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profil"),
        activeColorPrimary: Color(0xff4d87b7),
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(context),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          false, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(50.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.once,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.

        animateTabTransition: false,
        curve: Curves.decelerate,
        duration: Duration(milliseconds: 300),
      ),
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('data'),
      ),
    );
  }
}

// class BottomNav extends StatefulWidget {
//   const BottomNav({super.key});

//   @override
//   State<BottomNav> createState() => _BottomNavState();
// }

// class _BottomNavState extends State<BottomNav> {
//   var screens = [
//     Mobilitas(),
//     Peminjaman(),
//   ]; //screens for each tab

//   int selectedTab = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(38, 81, 158, 1),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'asd'),
//           BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'www'),
//         ],
//         onTap: (index) {
//           setState(() {
//             selectedTab = index;
//           });
//         },
//         showUnselectedLabels: true,
//         iconSize: 30,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         elevation: 0,
//         child: Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       body: screens[selectedTab],
//     );
//   }
// }
