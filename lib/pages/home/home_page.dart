import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/cart/cart_history.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/order/order_page.dart';

import '../account/account_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _seclectIndex=0;
  // late PersistentTabController _controller;

  List pages=[
    MainFoodPage(),
    OrderPage(),
    CartHistory(),
    AccountPage(),

  ];
  void onTapNav(int index)
  {
    setState(() {
      _seclectIndex=index;
    });
  }

  // @override
  // void initState(){
  //   super.initState();
  //   _controller = PersistentTabController(initialIndex: 0);
  // }
    // List<Widget> _buildScreens() {
    //       return [
    //   MainFoodPage(),
    //   Container(child: Center(child: Text("Next page 1"),),),
    //   Container(child: Center(child: Text("Next page 2"),),),
    //   Container(child: Center(child: Text("Next page 3"),),),
    //       ];
    //   }
  //   List<PersistentBottomNavBarItem> _navBarsItems() {
  //           return [
  //               PersistentBottomNavBarItem(
  //                   icon: Icon(CupertinoIcons.home),
  //                   title: ("Home"),
  //                   activeColorPrimary: CupertinoColors.activeBlue,
  //                   inactiveColorPrimary: CupertinoColors.systemGrey,
  //               ),
  //               PersistentBottomNavBarItem(
  //                   icon: Icon(CupertinoIcons.archivebox_fill),
  //                   title: ("Archive"),
  //                   activeColorPrimary: CupertinoColors.activeBlue,
  //                   inactiveColorPrimary: CupertinoColors.systemGrey,
  //               ),
  //                PersistentBottomNavBarItem(
  //                   icon: Icon(CupertinoIcons.car_fill),
  //                   title: ("Cart"),
  //                   activeColorPrimary: CupertinoColors.activeBlue,
  //                   inactiveColorPrimary: CupertinoColors.systemGrey,
  //               ),
  //               PersistentBottomNavBarItem(
  //                   icon: Icon(CupertinoIcons.person),
  //                   title: ("Person"),
  //                   activeColorPrimary: CupertinoColors.activeBlue,
  //                   inactiveColorPrimary: CupertinoColors.systemGrey,
  //               ),
  //           ];
  //       }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_seclectIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        currentIndex: _seclectIndex,
        onTap: onTapNav,
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
             label: 'Home'
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
             label: 'Archive'
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
             label: 'cart'         
            ), 
            BottomNavigationBarItem(
            icon: Icon(Icons.person),
             label: 'person'         
            ), 
        ]
        ),
    );
  }
    
    // @override
    //   Widget build(BuildContext context) {
    //     return PersistentTabView(
    //         context,
    //         controller: _controller,
    //         screens: _buildScreens(),
    //         items: _navBarsItems(),
    //         confineInSafeArea: true,
    //         backgroundColor: Colors.white, // Default is Colors.white.
    //         handleAndroidBackButtonPress: true, // Default is true.
    //         resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
    //         stateManagement: true, // Default is true.
    //         hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
    //         decoration: NavBarDecoration(
    //           borderRadius: BorderRadius.circular(10.0),
    //           colorBehindNavBar: Colors.white,
    //         ),
    //         popAllScreensOnTapOfSelectedTab: true,
    //         popActionScreens: PopActionScreensType.all,
    //         itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
    //           duration: Duration(milliseconds: 200),
    //           curve: Curves.ease,
    //         ),
    //         screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
    //           animateTabTransition: true,
    //           curve: Curves.ease,
    //           duration: Duration(milliseconds: 200),
    //         ),
    //         navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    //     );
    //   }
}