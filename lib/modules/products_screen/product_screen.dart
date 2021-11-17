import 'package:kinda_store_controller/modules/products_screen/product_details.dart';
import 'package:kinda_store_controller/shared/components/components.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:kinda_store_controller/layout/cubit/cubit.dart';
import 'package:kinda_store_controller/layout/cubit/states.dart';
import 'package:kinda_store_controller/models/product_model.dart';
import 'package:kinda_store_controller/styles/colors/colors.dart';

import 'delete_product_dialog.dart';



class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit, StoreAppStates>(
      listener: (context, state) {
        if(state is RemoveProductSuccessStates){
          showDialog(
            context: context,
            builder: (BuildContext context) => DeleteProductDialog(),
          );
        }
      },
      builder: (context, state) {
        var cubit = StoreAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            actions: <Widget>[
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Text(
                  "جميع المنتجات (${StoreAppCubit.get(context).products.length})",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
          body: Container(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: StoreAppCubit.get(context).products.length,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) {
                var list = StoreAppCubit.get(context).products;
                return buildFeedsItem(context, list[index]);
              },
            ),
          ),
        );
      },
    );
  }
}

Widget buildFeedsItem(context, Product model) {
  var cubit = StoreAppCubit.get(context);
  return InkWell(
    onTap: ()  {
      navigateTo(context, ProductDetailsScreen(productId: model.id,));
    },
    child: Container(
      margin: EdgeInsets.all(10.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xff37475A).withOpacity(0.2),
            blurRadius: 20.0,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              fit: BoxFit.fill,
              height: 180,
              image: NetworkImage(model.imageUrl),
              width: double.infinity,
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    model.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                     'ج.م',
                      style: TextStyle(
                        fontSize: 13.0.sp,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${model.price}',
                      style: TextStyle(
                        fontSize: 13.0.sp,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: defaultColor,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0)),
            ),
            width: double.infinity,
            height: 8.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    StoreAppCubit.get(context).removeProduct(model.id);
                  },
                  child: Icon(
                        Feather.trash,
                    size: 8.w,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:kinda_store_controller/layout/cubit/cubit.dart';
import 'package:kinda_store_controller/layout/cubit/states.dart';
import 'package:kinda_store_controller/models/product_model.dart';
import 'package:kinda_store_controller/shared/components/components.dart';

import 'delete_product_dialog.dart';


class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit, StoreAppStates>(
        listener: (context, state) {
          if(state is RemoveProductSuccessStates){
            showDialog(
              context: context,
              builder: (BuildContext context) => DeleteProductDialog(),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.grey[300],
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 9),
                  child: Text(
                    "جميع المنتجات (${StoreAppCubit.get(context).products.length})",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            body:SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 25,),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var list=StoreAppCubit.get(context).products;
                      return buildProductItem(context,list[index]);
                    },
                    separatorBuilder: (context, index) => Container(
                      height: 8,
                    ),
                    itemCount: StoreAppCubit.get(context).products.length,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
Widget buildProductItem(context ,Product products) => Stack(
  children: [
    Container(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${products.title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${products.price}\$',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${products.productCategoryName}',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${products.description}',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Container(
            width: 120,
            height: 165,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    products.imageUrl),
              ),
            ),
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
    Positioned(
      top: 155,
      left: 7,
      child: Container(
        height: 30,
        width: 30,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          color: Colors.redAccent,
          child: CircleAvatar(
            radius: 18.0,
            backgroundColor: Colors.white,
            child: Icon(
              Feather.trash,
              size: 20.0,
              color: Colors.black,
            ),
          ),
          onPressed: () {
            StoreAppCubit.get(context).removeProduct(products.id);
          },
        ),
      ),
    ),
  ],
);*/
