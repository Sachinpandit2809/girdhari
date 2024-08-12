import 'package:flutter/material.dart';
import 'package:girdhari/features/orders/controller/order_provider.dart';
import 'package:girdhari/features/orders/model/order_model.dart';
import 'package:girdhari/features/orders/screens/orders_details_screen.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/widgets/common/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/common/rectangular_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderScreenCard extends StatelessWidget {
  OrderModel order;
  OrderScreenCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        debugPrint("....................triggred");
        showDialog(
            context: context,
            builder: (context) {
              return Consumer<OrderProvider>(
                  builder: (context, orderProvider, _) {
                return AlertDialog(
                  content: SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("are you sure want to delete"),
                        FlexiableRectangularButton(
                            title: "delete",
                            width: 140,
                            height: 40,
                            color: AppColor.brownRed,
                            loading: orderProvider.delLoading,
                            onPress: () {
                              orderProvider.setDelLoading(true);
                              OrderModel softDelete = OrderModel(
                                  id: order.id,
                                  client: order.client,
                                  orderList: order.orderList,
                                  is_deleted: true,
                                  date: order.date);
                              orderProvider.deleteOrder(softDelete);
                            })
                      ],
                    ),
                  ),
                );
              });
            });
      },
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contex) => OrdersDetailsScreen(
                      clientDetails: order.client,
                      orderProductList: order.orderList,
                      order: order,
                    )));
        final g = Provider.of<ModifyBillProduct>(context, listen: false);
        g.setModifiedProductList(order);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                offset: const Offset(0, 1),
                blurRadius: 6,
                spreadRadius: 0,
                blurStyle: BlurStyle.outer,
              )
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //details
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.client.clientName,
                  style: KTextStyle.K_14,
                ),
                Text(
                  order.client.address,
                  style: KTextStyle.K_10,
                ),
                const SizedBox(
                  height: 4,
                ),
                RectangularButton(
                    title: DateFormat('dd-MM-yy').format(order.date),
                    color: AppColor.yellow)
              ],
            ),
            //figure
            RectangularButton(
                onPress: () {
                  debugPrint(order.status.name);
                },
                title: order.status.name,
                color: order.status.name == "Pending"
                    ? AppColor.yellowButton
                    : AppColor.green)
          ],
        ),
      ),
    );
  }
}
