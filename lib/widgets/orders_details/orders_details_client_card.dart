import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:girdhari/features/orders/controller/order_provider.dart';
import 'package:girdhari/features/orders/model/order_model.dart';
import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/widgets/common/rectangular_button.dart';

class OrdersDetailsClientCard extends StatelessWidget {
  OrdersDetailsClientCard(
      {super.key, required this.modifyBillProduct, required this.order});
  final ModifyBillProduct modifyBillProduct;
  OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary,
              offset: const Offset(0, 0),
              blurRadius: 5,
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
                modifyBillProduct.clientModel.clientName,
                style: KTextStyle.K_14,
              ),
              Text(
                modifyBillProduct.clientModel.address,
                style: KTextStyle.K_10,
              ),
            ],
          ),
          //figure
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RectangularButton(
                  title:
                      "${order.date.day}-${order.date.month}-${order.date.year}",
                  color: AppColor.yellow),
              const SizedBox(
                height: 4,
              ),
              RectangularButton(
                  title: order.status.name,
                  color: order.status.name == "Pending"
                      ? AppColor.skyBlueButton
                      : AppColor.green),
            ],
          )
        ],
      ),
    );
  }
}
