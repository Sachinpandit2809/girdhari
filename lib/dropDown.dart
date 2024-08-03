import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:girdhari/utils/utils.dart';
import 'package:textfield_search/textfield_search.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const TestPage(),
//     );
//   }
// }

// class NewPage extends StatelessWidget {
//   const NewPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(onPressed: () {
//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: (context) => TestPage()));
//       }),
//     );
//   }
// }

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
//   final fireStore =
//       FirebaseFirestore.instance.collection("productStock").snapshots();
//   final fireStoreRef = FirebaseFirestore.instance.collection("productStock");

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   FocusNode searchFocusNode = FocusNode();
//   FocusNode textFieldFocusNode = FocusNode();
//   late SingleValueDropDownController _cnt;
//   late MultiValueDropDownController _cntMulti;
//   String initalValue = "abc";
//   @override
//   void initState() {
//     _cnt = SingleValueDropDownController();
//     _cntMulti = MultiValueDropDownController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _cnt.dispose();
//     _cntMulti.dispose();
//     super.dispose();
//   }

//   List productList = [];
//   List productNameList = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: StreamBuilder<QuerySnapshot>(
//           stream: fireStore,
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             }
//             if (snapshot.hasError) {
//               Utils().toastErrorMessage("error during communication");
//             }
//             if (snapshot.hasData) {
//               for (var i = 0; i < snapshot.data!.docs.length; i++) {
//                 productList.add(snapshot.data!.docs[i].data());
//                 // ignore: prefer_interpolation_to_compose_strings
//                 productNameList.add(productList[i]['productName']);
//                 // ignore: prefer_interpolation_to_compose_strings
//                 debugPrint("############" + productList[i]['productName']);
//               }
//               debugPrint("...............$productList");
//               debugPrint("****************$productNameList");
//             }

//             //     return ListView.builder(
//             //       itemCount: snapshot.data!.docs.length,
//             //       itemBuilder: (context, index) {
//             //         return Text(" data $index");
//             //       },
//             //     );
//             // )
//             return Form(
//               key: _formKey,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(
//                       height: 50,
//                     ),
//                     const Text(
//                       "Single selection dropdown with search option",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     DropDownTextField(
//                       controller: _cnt,
//                       clearOption: true,
//                       enableSearch: true,
//                       clearIconProperty: IconProperty(color: Colors.green),
//                       searchTextStyle: const TextStyle(color: Colors.red),
//                       searchDecoration: const InputDecoration(
//                           hintText: "enter your custom hint text here"),
//                       validator: (value) {
//                         if (value == null) {
//                           return "Required field";
//                         } else {
//                           return null;
//                         }
//                       },
//                       dropDownItemCount: 6,
//                       dropDownList: [],
//                       onChanged: (val) {},
//                     ),
//                     const SizedBox(
//                       height: 500,
//                     ),
//                     const Text(
//                       "Single selection dropdown with search option",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     DropDownTextField(
//                       clearOption: false,
//                       textFieldFocusNode: textFieldFocusNode,
//                       searchFocusNode: searchFocusNode,
//                       // searchAutofocus: true,
//                       dropDownItemCount: 8,
//                       searchShowCursor: false,
//                       enableSearch: true,
//                       searchKeyboardType: TextInputType.number,
//                       dropDownList: const [
//                         DropDownValueModel(name: 'name1', value: "value1"),
//                         DropDownValueModel(
//                             name: 'name2',
//                             value: "value2",
//                             toolTipMsg:
//                                 "DropDownButton is a widget that we can use to select one unique value from a set of values"),
//                         DropDownValueModel(name: 'name3', value: "value3"),
//                         DropDownValueModel(
//                             name: 'name4',
//                             value: "value4",
//                             toolTipMsg:
//                                 "DropDownButton is a widget that we can use to select one unique value from a set of values"),
//                         DropDownValueModel(name: 'name5', value: "value5"),
//                         DropDownValueModel(name: 'name6', value: "value6"),
//                         DropDownValueModel(name: 'name7', value: "value7"),
//                         DropDownValueModel(name: 'name8', value: "value8"),
//                       ],
//                       onChanged: (val) {},
//                     ),
//                     const SizedBox(
//                       height: 500,
//                     ),
//                     const Text(
//                       "multi selection dropdown",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     DropDownTextField.multiSelection(
//                       controller: _cntMulti,
//                       // initialValue: const ["name1", "name2", "name8", "name3"],
//                       // displayCompleteItem: true,
//                       checkBoxProperty: CheckBoxProperty(
//                           fillColor:
//                               MaterialStateProperty.all<Color>(Colors.red)),
//                       dropDownList: const [
//                         DropDownValueModel(name: 'name1', value: "value1"),
//                         DropDownValueModel(
//                             name: 'name2',
//                             value: "value2",
//                             toolTipMsg:
//                                 "DropDownButton is a widget that we can use to select one unique value from a set of values"),
//                         DropDownValueModel(name: 'name3', value: "value3"),
//                         DropDownValueModel(
//                             name: 'name4',
//                             value: "value4",
//                             toolTipMsg:
//                                 "DropDownButton is a widget that we can use to select one unique value from a set of values"),
//                         DropDownValueModel(name: 'name5', value: "value5"),
//                         DropDownValueModel(name: 'name6', value: "value6"),
//                         DropDownValueModel(name: 'name7', value: "value7"),
//                         DropDownValueModel(name: 'name8', value: "value8"),
//                       ],
//                       onChanged: (val) {
//                         setState(() {});
//                       },
//                     ),
//                     const SizedBox(
//                       height: 50,
//                     ),
//                     const Text(
//                       "Single selection dropdown",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     DropDownTextField(
//                       // initialValue: "name4",
//                       listSpace: 20,
//                       listPadding: ListPadding(top: 20),
//                       enableSearch: true,
//                       validator: (value) {
//                         if (value == null) {
//                           return "Required field";
//                         } else {
//                           return null;
//                         }
//                       },
//                       dropDownList: const [
//                         DropDownValueModel(name: 'name1', value: "value1"),
//                         DropDownValueModel(name: 'name2', value: "value2"),
//                         DropDownValueModel(name: 'name3', value: "value3"),
//                         DropDownValueModel(name: 'name4', value: "value4"),
//                         DropDownValueModel(name: 'name5', value: "value5"),
//                         DropDownValueModel(name: 'name6', value: "value6"),
//                         DropDownValueModel(name: 'name7', value: "value7"),
//                         DropDownValueModel(name: 'name8', value: "value8"),
//                       ],
//                       listTextStyle: const TextStyle(color: Colors.red),
//                       dropDownItemCount: 8,

//                       onChanged: (val) {},
//                     ),
//                     const SizedBox(
//                       height: 50,
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           _cntMulti.clearDropDown();
//         },
//         label: const Text("Submit"),
//       ),
//     );
//   }
// }


TextEditingController myController = TextEditingController();

    // create a Future that returns List
    // IMPORTANT: The list that gets returned from fetchData must have objects that have a label property.
    // The label property is what is used to populate the TextField while getSelectedValue returns the actual object selected
    Future<List> fetchData() async {
      await Future.delayed(Duration(milliseconds: 3000));
      List list = [];
      String _inputText = myController.text;
      List _jsonList = [
        {
          'label': _inputText + ' Item 1',
          'value': 30
        },
        {
          'label': _inputText + ' Item 2',
          'value': 31
        },
        {
          'label': _inputText + ' Item 3',
          'value': 32
        },
      ];
      // create a list of 3 objects from a fake json response
      list.add(new TestItem.fromJson(_jsonList[0]));
      list.add(new TestItem.fromJson(_jsonList[1]));
      list.add(new TestItem.fromJson(_jsonList[2]));
      return list;
    }

    @override
    void dispose() {
      // Clean up the controller when the widget is removed from the
      // widget tree.
      myController.dispose();
      super.dispose();
    }

    // used within a MaterialApp (code shortened)
      Widget build(BuildContext context) {
        return Scaffold(
      body: TextFieldSearch(
          label: 'My Label', 
          controller: myController,
          future: () {
            return fetchData();
          },
          getSelectedValue: (value) {
            print(value); // this prints the selected option which could be an object
          }
      
        ));
      }}

    // Mock Test Item Class

          class TestItem {
      String label;
      dynamic value;
      TestItem({
        required this.label,
        this.value
      });

      factory TestItem.fromJson(Map<String, dynamic> json) {
        return TestItem(
          label: json['label'],
          value: json['value']
        );
      }
      
      }