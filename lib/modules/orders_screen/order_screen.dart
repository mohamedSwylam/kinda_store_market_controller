import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:kinda_store_controller/layout/cubit/cubit.dart';
import 'package:kinda_store_controller/layout/cubit/states.dart';
import 'package:kinda_store_controller/models/order_model.dart';
import 'package:kinda_store_controller/models/product_model.dart';
import 'package:sizer/sizer.dart';
import 'package:kinda_store_controller/styles/colors/colors.dart';

import 'delete_order_dialog.dart';

class OrdersScreen extends StatelessWidget {
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
                height: 5.h,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var list = StoreAppCubit.get(context).orders;
                  return buildProductItem(context, list[index]);
                },
                separatorBuilder: (context, index) => Container(
                  height: 2.h,
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
                height: 25.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(model.imageUrl),
                  ),
                ),
              ),
              SizedBox(height: 4.h,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50.w,
                          child: Text(
                            '${model.username}',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp),
                          ),
                        ),
                       Spacer(),
                        Text(
                          'اسم العميل',
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp,color: defaultColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50.w,
                            child: Text(
                              '${model.userAddress}',
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp),
                            ),
                          ),
                          Spacer(),
                          Text(
                            'عنوان العميل',
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp,color: defaultColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50.w,
                          child: Text(
                            '${model.addressDetails}',
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp),
                          ),
                        ),
                        Spacer(),

                        Text(
                          'تفاصيل العنوان',
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp,color: defaultColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50.w,
                          child: Text(
                            '${model.userPhone}',
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'رقم التواصل',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp,color: defaultColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50.w,
                          child: Text(
                            '${model.anotherNumber}',

                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp,),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'الرقم اخر للتواصل',
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp,color: defaultColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height:1.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50.w,
                          child: Text(
                            '',

                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp),
                          ),
                        ),
                        Spacer(),

                        Text(
                          'المنتجات',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp,color: defaultColor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return buildProductsItem(context,model.prices[index]);
                            },
                            itemCount: model.prices.length,
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return buildProductsItem(context,model.quantities[index]);
                            },
                            itemCount: model.quantities.length,
                          ),
                          flex: 1,
                        ),
                        SizedBox(width: 5.w,),
                        Expanded(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return buildProductsItem(context,model.products[index]);
                            },
                            itemCount: model.products.length,
                          ),
                          flex: 2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50.w,
                          child: Text(
                            '${model.subTotal}',

                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'السعر الكلي',
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp,color: defaultColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50.w,
                          child: Text(
                            '10',

                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp),
                          ),
                        ),
                        Spacer(),

                        Text(
                          'الشحن',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp,color: defaultColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50.w,
                          child: Text(
                            '${model.total}',

                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'الاجمالي',

                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp,color: defaultColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
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
                            'انهاء الطلب',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:
                                    Theme.of(context).textSelectionColor,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5.0.w,
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
Widget buildProductsItem(context,model) => Text(
  '${model}',
  textAlign: TextAlign.end,
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 13.sp),
);
