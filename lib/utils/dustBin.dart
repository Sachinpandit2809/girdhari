   // Container(
                    //   decoration: BoxDecoration(
                    //     color: AppColor.grey,
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   padding: const EdgeInsets.symmetric(vertical: 4),
                    //   // Set background color of the TabBar
                    //   child: TabBar(
                    //     padding: const EdgeInsets.symmetric(vertical: 10),
                    //     indicatorPadding: const EdgeInsets.symmetric(
                    //         horizontal: -15, vertical: -10),
                    //     dividerColor: AppColor.grey.withOpacity(0),
                    //     // indicatorWeight: 4.0,
                    //     unselectedLabelStyle: KTextStyle.K_10,
                    //     indicator: BoxDecoration(
                    //       shape: BoxShape.rectangle,
                    //       borderRadius:
                    //           const BorderRadius.all(Radius.circular(8)),
                    //       color: Theme.of(context).colorScheme.secondary,
                    //     ),
                    //     controller: tabController,
                    //     tabs: const <Widget>[
                    //       Text(
                    //         "Raw Material",
                    //         style: KTextStyle.K_14,
                    //       ),
                    //       Text(
                    //         "Packaging",
                    //         style: KTextStyle.K_14,
                    //       ),
                    //       Text(
                    //         "Others",
                    //         style: KTextStyle.K_14,
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    // ToggleButtons(
                    //   isSelected: [
                    //     selectedCategory == 'Raw Material',
                    //     selectedCategory == 'Packaging',
                    //     selectedCategory == 'Others',
                    //   ],
                    //   onPressed: (int index) {
                    //     setState(() {
                    //       toggleLoading = true;
                    //       switch (index) {
                    //         case 0:
                    //           selectedCategory = 'Raw Material';
                    //           break;
                    //         case 1:
                    //           selectedCategory = 'Packaging';
                    //           break;
                    //         case 2:
                    //           selectedCategory = 'Others';
                    //           break;
                    //       }
                    //     });
                    //   },
                    //   selectedColor: Colors.white, // Color of selected text
                    //   fillColor:
                    //       Colors.blue, // Background color of selected button
                    //   color: Colors.black, // Color of unselected text

                    //   children: const [
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 16.0),
                    //       child: Text('Raw Material'),
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 16.0),
                    //       child: Text('Packaging'),
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 16.0),
                    //       child: Text('Others'),
                    //     ),
                    //   ],
                    // ),