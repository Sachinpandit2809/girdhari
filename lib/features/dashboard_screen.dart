// import 'package:flutter/material.dart';
// import 'package:girdhari/resource/app_color.dart';
// import 'package:girdhari/features/orders/screens/billing_screen.dart';
// import 'package:girdhari/features/client/screens/client_screen.dart';
// import 'package:girdhari/features/orders/screens/orders_screen.dart';
// import 'package:girdhari/features/product/screens/stock_record_screen.dart';

// class DashBoardScreen extends StatefulWidget {
//   const DashBoardScreen({super.key});

//   @override
//   State<DashBoardScreen> createState() => _DashBoardScreenState();
// }

// class _DashBoardScreenState extends State<DashBoardScreen> {
//   int _selectedIndex = 0;

//   static const List<Widget> _widgetOptions = <Widget>[
//     //first bootom bar
//     StockRecordScreen(),
//     //second bottom bar
//     ClientScreen(),
//     //third dcreen
//     BillingScreen(),
//     //fourth bottom bar
//     OrdersScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   final List<BottomNavigationBarItem> _bottomNavigationBarItems =
//       const <BottomNavigationBarItem>[
//     BottomNavigationBarItem(
//       icon: Icon(Icons.business),
//       label: '',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.person_outlined),
//       label: '',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.currency_rupee),
//       label: '',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.settings),
//       label: '',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: _widgetOptions,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         elevation: 0,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         unselectedItemColor: Colors.grey,
//         items: _bottomNavigationBarItems,
//         currentIndex: _selectedIndex,
//         selectedItemColor: AppColor.brown,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/features/orders/screens/billing_screen.dart';
import 'package:girdhari/features/client/screens/client_screen.dart';
import 'package:girdhari/features/orders/screens/orders_screen.dart';
import 'package:girdhari/features/product/screens/stock_record_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    //first bootom bar
    StockRecordScreen(),
    //second bottom bar
    ClientScreen(),
    //third dcreen
    BillingScreen(),
    //fourth bottom bar
    OrdersScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_rupee),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.brown,
        onTap: _onItemTapped,
      ),
    );
  }
}
