import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:kinda_store_controller/layout/cubit/cubit.dart';
import 'package:kinda_store_controller/layout/cubit/states.dart';
import 'package:kinda_store_controller/styles/colors/colors.dart';
import 'add_product_dialog.dart';
import 'package:sizer/sizer.dart';


class AddProductScreen extends StatelessWidget {
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
            StoreAppCubit.get(context).productTitleEnController.clear();
            StoreAppCubit.get(context).productDescriptionController.clear();
            StoreAppCubit.get(context).productDescriptionEnController.clear();
            StoreAppCubit.get(context).productCategory = 'صنف المنتج';
            StoreAppCubit.get(context).productCategory = 'صنف المنتج بالانجليزيه';
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
                    height: 4.h,
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
                            height: 30.h,
                            width: 70.w,
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
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'اختر طريقه',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13.sp,
                                              color:
                                              defaultColor),
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
                                                        size: 7.w,
                                                        color: Colors.yellow[700],
                                                      ),
                                                    ),
                                                    Text(
                                                      'الكاميرا',
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
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
                                                      .getImageGallery();
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
                                                        size: 7.w,
                                                        color: Colors.yellow[700],
                                                      ),
                                                    ),
                                                    Text(
                                                      'المعرض',
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
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
                                                        size: 7.w,
                                                      ),
                                                    ),
                                                    Text(
                                                      'حذف',
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
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
                              child: Center(
                                child: Icon(
                                  Feather.camera,
                                  color: Colors.white,
                                  size: 6.w,
                                ),
                              ),
                            ),
                            backgroundColor: defaultColor,
                            radius: 5.w,
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
                            labelStyle: TextStyle(fontSize: 12.sp),
                            fillColor: Theme.of(context).backgroundColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: cubit.productTitleEnController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'ادخل اسم المنتج بالانجليزيه';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: ' اسم المنتج بالانجليزيه',
                            labelStyle: TextStyle(fontSize: 12.sp),
                            fillColor: Theme.of(context).backgroundColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
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
                            labelStyle: TextStyle(fontSize: 12.sp),
                            fillColor: Theme.of(context).backgroundColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: cubit.productDescriptionController,
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
                            labelStyle: TextStyle(fontSize: 12.sp),
                            fillColor: Theme.of(context).backgroundColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: cubit.productDescriptionEnController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'ادخل وصف المنتج بالانجليزيه';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'وصف المنتج بالانجليزيه',
                            labelStyle: TextStyle(fontSize: 12.sp),
                            fillColor: Theme.of(context).backgroundColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: double.infinity,
                      height: 10.h,
                      child: DropdownButton<String>(
                        iconSize: 7.w,
                        items: [
                          DropdownMenuItem<String>(
                            child: Text('توابل',style: TextStyle(fontSize: 13.sp),),
                            value: 'توابل',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('مجمدات',style: TextStyle(fontSize: 13.sp),),
                            value: 'مجمدات',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('مشروبات',style: TextStyle(fontSize: 13.sp),),
                            value: 'مشروبات',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('مثلجات',style: TextStyle(fontSize: 13.sp),),
                            value: 'مثلجات',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('جبن',style: TextStyle(fontSize: 13.sp),),
                            value: 'جبن',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('صوصات',style: TextStyle(fontSize: 13.sp),),
                            value: 'صوصات',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('مخبوزات',style: TextStyle(fontSize: 13.sp),),
                            value: 'مخبوزات',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('شيكولاته',style: TextStyle(fontSize: 13.sp),),
                            value: 'شيكولاته',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('حلوي',style: TextStyle(fontSize: 13.sp),),
                            value: 'حلوي',
                          ),DropdownMenuItem<String>(
                            child: Text('مكسرات',style: TextStyle(fontSize: 13.sp),),
                            value: 'مكسرات',
                          ),DropdownMenuItem<String>(
                            child: Text('بقاله',style: TextStyle(fontSize: 13.sp),),
                            value: 'بقاله',
                          ),
                        ],
                        onChanged: (value) => cubit.changeCategory(value),
                        hint: Center(child: Text('${cubit.productCategory}',style: TextStyle(fontSize: 11.sp),)),
                        borderRadius: BorderRadius.circular(10),
                        isExpanded: true,
                        isDense: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: double.infinity,
                      height: 7.h,
                      child: DropdownButton<String>(
                        iconSize: 7.w,
                        items: [
                          DropdownMenuItem<String>(
                            child: Text('Spices',style: TextStyle(fontSize: 13.sp),),
                            value: 'Spices',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Freezers',style: TextStyle(fontSize: 13.sp),),
                            value: 'Freezers',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Drinks',style: TextStyle(fontSize: 13.sp),),
                            value: 'Drinks',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Ice cream',style: TextStyle(fontSize: 13.sp),),
                            value: 'Ice cream',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Cheeses',style: TextStyle(fontSize: 13.sp),),
                            value: 'Cheeses',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Sauces',style: TextStyle(fontSize: 13.sp),),
                            value: 'Sauces',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Bakery',style: TextStyle(fontSize: 13.sp),),
                            value: 'Bakery',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Chocolates',style: TextStyle(fontSize: 13.sp),),
                            value: 'Chocolates',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Sweets',style: TextStyle(fontSize: 13.sp),),
                            value: 'Sweets',
                          ),DropdownMenuItem<String>(
                            child: Text('Nuts ',style: TextStyle(fontSize: 13.sp),),
                            value: 'Nuts',
                          ),DropdownMenuItem<String>(
                            child: Text('Grocery',style: TextStyle(fontSize: 13.sp),),
                            value: 'Grocery',
                          ),
                        ],
                        onChanged: (value) => cubit.changeCategoryEn(value),
                        hint: Center(child: Text('${cubit.productCategoryEn}',style: TextStyle(fontSize:13.sp),)),
                        borderRadius: BorderRadius.circular(10),
                        isExpanded: true,
                        isDense: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
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
                                      fontSize: 14.sp),
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                Icon(
                                  Icons.add,
                                  size: 6.w,
                                )
                              ],
                            )),
                        width: 50.w,
                        height: 9.h,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );  }
}

