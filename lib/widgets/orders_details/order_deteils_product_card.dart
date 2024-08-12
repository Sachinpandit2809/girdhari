import 'package:flutter/material.dart';
import 'package:girdhari/features/orders/controller/order_provider.dart';

import 'package:girdhari/resource/app_color.dart';
import 'package:girdhari/resource/k_text_style.dart';
import 'package:girdhari/widgets/common/flexiable_rectangular_button.dart';
import 'package:girdhari/widgets/common/rectangular_button.dart';
import 'package:girdhari/widgets/common/small_square_button.dart';

class OrderDeteilsProductCard extends StatelessWidget {
  final ModifyBillProduct modifyBillProduct;
  final int index;

  const OrderDeteilsProductCard({super.key ,required this.modifyBillProduct,required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  modifyBillProduct.modifiedProductList[index].productName,
                  style: KTextStyle.K_16,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RectangularButton(
                      title: modifyBillProduct
                          .modifiedProductList[index].packaging,
                      color: AppColor.skyBlueButton),
                  RectangularButton(
                      title:
                          modifyBillProduct.modifiedProductList[index].weight,
                      color: AppColor.yellowButton),
                  SmallSquareButton(
                      title: (modifyBillProduct
                                  .modifiedProductList[index].totalPrice /
                              modifyBillProduct
                                  .modifiedProductList[index].selectedQuantity)
                          .toString(),
                      color: AppColor.lowGreen),
                  SmallSquareButton(
                      title: modifyBillProduct
                          .modifiedProductList[index].selectedQuantity
                          .toString(),
                      color: AppColor.yellow),
                ],
              )
            ],
          ),
          Row(
            children: [
              FlexiableRectangularButton(
                  textColor: Colors.black,
                  title: modifyBillProduct.modifiedProductList[index].totalPrice
                      .toString(),
                  width: 51,
                  height: 46,
                  onPress: () {},
                  color: AppColor.skyBlueButton),
            ],
          ),
        ],
      ),
    );
  }
}
