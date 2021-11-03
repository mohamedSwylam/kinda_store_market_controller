import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:kinda_store_controller/layout/cubit/cubit.dart';
import 'package:kinda_store_controller/layout/cubit/states.dart';
import 'package:kinda_store_controller/models/order_model.dart';
import 'package:kinda_store_controller/models/product_model.dart';
import 'package:kinda_store_controller/shared/components/components.dart';
import 'package:kinda_store_controller/styles/colors/colors.dart';

import 'delete_order_dialog.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit, StoreAppStates>(
        listener: (context, state) {
       if(state is RemoveOrderSuccessStates){
            showDialog(
              context: context,
              builder: (BuildContext context) => DeleteOrderDialog(),
            );
          }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.grey[300],
          actions: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 9),
              child: Text(
                " طلبات الزبائن (${StoreAppCubit.get(context).orders.length})",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 25,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var list = StoreAppCubit.get(context).orders;
                  return buildProductItem(context, list[index]);
                },
                separatorBuilder: (context, index) => Container(
                  height: 8,
                ),
                itemCount: StoreAppCubit.get(context).orders.length,
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget buildProductItem(context, OrderModel model) => Stack(
      children: [
        Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 165,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(model.imageUrl),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${model.username}',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'اسم العميل',
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              '${model.userAddress}',
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'عنوان العميل',
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 170,
                          child: Text(
                            '${model.addressDetails}',
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'تفاصيل العنوان',
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${model.userPhone}',
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'رقم التواصل',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${model.anotherNumber}',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'الرقم الاخر للتواصل',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${model.title}',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'اسم المنتج',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${model.quantity}',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'الكميه',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${model.price}',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'سعر المنتج',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${model.subTotal}',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'الاجمالي',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '10',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'الشحن',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${model.total}',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'السعر الكلي',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: RaisedButton(
                          onPressed: () {
                            StoreAppCubit.get(context)
                                .removeOrder(model.orderId);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: defaultColor,
                            ),
                          ),
                          color: defaultColor,
                          child: Text(
                            'حذف الطلب',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:
                                    Theme.of(context).textSelectionColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
            ],
          ),
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 15,
            top: 15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(16.0),
              topLeft: const Radius.circular(16.0),
              bottomRight: const Radius.circular(16.0),
              topRight: const Radius.circular(16.0),
            ),
            color: Theme.of(context).backgroundColor,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
        ),
      ],
    );
