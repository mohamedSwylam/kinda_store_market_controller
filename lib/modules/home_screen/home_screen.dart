import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:badges/badges.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:kinda_store_controller/layout/cubit/cubit.dart';
import 'package:kinda_store_controller/layout/cubit/states.dart';
import 'package:kinda_store_controller/shared/components/components.dart';
import 'package:kinda_store_controller/styles/colors/colors.dart';

import 'add_product_dialog.dart';


class HomeScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   return BlocConsumer<StoreAppCubit, StoreAppStates>(
      listener: (context, state) {
        if (state is CreateProductSuccessState) {
            showDialog(
              context: context,
              builder: (BuildContext context) => AddProductDialog(),
            );
            StoreAppCubit.get(context).productTitleController.clear();
            StoreAppCubit.get(context).productDescriptionController.clear();
            StoreAppCubit.get(context).productCategory = 'صنف المنتج';
            StoreAppCubit.get(context).url ='https://kisss.cc/wp-content/uploads/2018/07/2761.jpg';
        }
      },
      builder: (context, state) {
        var productImage = StoreAppCubit.get(context).productImage;
        var cubit = StoreAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.grey[300],
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 9),
                child: Text(
                  "اضافه منتج",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Expanded(
                          //  flex: 2,
                          child: productImage == null
                              ? Container(
                            margin: EdgeInsets.all(10),
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(4),
                              color: Theme.of(context).backgroundColor,
                            ),
                          )
                              : Container(
                            margin: EdgeInsets.all(10),
                            height: 200,
                            width: 200,
                            child: Container(
                              height: 200,
                              // width: 200,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.only(
                                //   topLeft: const Radius.circular(40.0),
                                // ),
                                color: Theme.of(context).backgroundColor,
                              ),
                              child: Image.file(
                                productImage,
                                fit: BoxFit.fill,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircleAvatar(
                            child: IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'اختر طريقه',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color:
                                              ColorsConsts.gradiendLStart),
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  StoreAppCubit.get(context)
                                                      .pickImageCamera();
                                                  Navigator.pop(context);
                                                },
                                                splashColor: Colors.yellow[700],
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                      child: Icon(
                                                        Icons.camera,
                                                        color: Colors.yellow[700],
                                                      ),
                                                    ),
                                                    Text(
                                                      'الكاميرا',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: ColorsConsts
                                                              .title),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  StoreAppCubit.get(context)
                                                      .getProfileImageGallery();
                                                  Navigator.pop(context);
                                                },
                                                splashColor: Colors.yellow[700],
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                      child: Icon(
                                                        Icons.image,
                                                        color: Colors.yellow[700],
                                                      ),
                                                    ),
                                                    Text(
                                                      'المعرض',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: ColorsConsts
                                                              .title),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  StoreAppCubit.get(context)
                                                      .remove();
                                                  Navigator.pop(context);
                                                },
                                                splashColor: Colors.yellow[700],
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                      child: Icon(
                                                        Icons.remove_circle,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    Text(
                                                      'حذف',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: Colors.red),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              icon: Icon(
                                Feather.camera,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            backgroundColor: defaultColor,
                            radius: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: cubit.productTitleController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'ادخل اسم المنتج';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'اسم المنتج',
                            fillColor: Theme.of(context).backgroundColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: double.infinity,
                      child: TextFormField(
                        key: ValueKey('Price \$'),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]')),
                        ],
                        validator: (value) {
                          if (value.isEmpty && value is String) {
                            return 'ادخل سعر المنتج';
                          }
                          return null;
                        },
                        onChanged: (value)=>cubit.inputPrice(value),
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'سعر المنتج',
                            fillColor: Theme.of(context).backgroundColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: cubit.productDescriptionController,
                        maxLines: 10,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'ادخل وصف المنتج';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'وصف المنتج',
                            fillColor: Theme.of(context).backgroundColor),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      child: DropdownButton<String>(
                        items: [
                          DropdownMenuItem<String>(
                            child: Text('توابل'),
                            value: 'توابل',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('مجمدات'),
                            value: 'مجمدات',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('مشروبات'),
                            value: 'مشروبات',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('مثلجات'),
                            value: 'مثلجات',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('جبن'),
                            value: 'جبن',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('صوصات'),
                            value: 'صوصات',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('مخبوزات'),
                            value: 'مخبوزات',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('شيكولاته'),
                            value: 'شيكولاته',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('حلوي'),
                            value: 'حلوي',
                          ),DropdownMenuItem<String>(
                            child: Text('مكسرات'),
                            value: 'مكسرات',
                          ),DropdownMenuItem<String>(
                            child: Text('بقاله'),
                            value: 'بقاله',
                          ),
                        ],
                        onChanged: (value) => cubit.changeCategory(value),
                        hint: Center(child: Text('${cubit.productCategory}')),
                        borderRadius: BorderRadius.circular(10),
                        isExpanded: true,
                        isDense: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Container(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(
                                        color:defaultColor),
                                  ),
                                )),
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                StoreAppCubit.get(context)
                                    .createProduct(context);
                                StoreAppCubit.get(context).getProduct();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'اضافه منتج',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.add,
                                  size: 18,
                                )
                              ],
                            )),
                        width: 180,
                        height: 50,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );  }
}

