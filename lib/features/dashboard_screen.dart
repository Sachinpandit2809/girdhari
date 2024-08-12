import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:girdhari/features/expenses/screen/expenses_screen.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/features/orders/screens/billing_screen.dart';
import 'package:girdhari/features/client/screens/client_screen.dart';
import 'package:girdhari/features/orders/screens/orders_screen.dart';
import 'package:girdhari/features/product/screens/stock_record_screen.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/widgets/common/flexiable_rectangular_button.dart';

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
    // //third dcreen
    // BillingScreen(),
    //fourth bottom bar
    OrdersScreen(),
    //fifth screen bar
    ExpensesScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("exit app"),
              content:  Text(
                "do you want to exit?",
                style: KTextStyle.K_15,
              ),
              actions: [
                FlexiableRectangularButton(
                    title: "no",
                    width: 70,
                    height: 25,
                    color: AppColor.brown,
                    onPress: () {
                      Navigator.of(context).pop(false);
                    }),
                FlexiableRectangularButton(
                    title: "yes",
                    width: 70,
                    height: 25,
                    color: AppColor.brown,
                    onPress: () {
                      SystemNavigator.pop();
                    })
              ],
            );
          },
        );
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(value);
        }
      },
      child: Scaffold(
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
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.currency_rupee),
            //   label: '',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money_outlined),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColor.brown,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}



// class DashBoardScreen extends StatefulWidget {
//   const DashBoardScreen({super.key});

//   @override
//   _DashBoardScreenState createState() => _DashBoardScreenState();
// }

// class _DashBoardScreenState extends State<DashBoardScreen> {
//   int _selectedIndex = 0;

//   static const List<Widget> _widgetOptions = <Widget>[
//     StockRecordScreen(),
//     ClientScreen(),
//     BillingScreen(),
//     OrdersScreen(),
//     ExpensesScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

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
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.business),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outlined),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.currency_rupee),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.attach_money_outlined),
//             label: '',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: AppColor.brown,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
