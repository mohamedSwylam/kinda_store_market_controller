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
import 'package:kinda_store_controller/models/banner_model.dart';
import 'package:kinda_store_controller/shared/components/components.dart';
import 'package:kinda_store_controller/styles/colors/colors.dart';

import 'banner_dialog.dart';



class UserScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit, StoreAppStates>(
      listener: (context, state) {
       if (state is CreateBannerSuccessState) {
          showDialog(
            context: context,
            builder: (BuildContext context) => BannerDialog(),
          );
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
                  "اضافه صور العرض",
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
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(4),
                            color: Theme.of(context).backgroundColor,
                          ),
                        )
                            : Container(
                          margin: EdgeInsets.all(10),
                          height: 200,
                          width: double.infinity,
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
                              StoreAppCubit.get(context).uploadBanner(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'اضافه',
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
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 9),
                  child: Text(
                    " صور العرض",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),

                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var list=StoreAppCubit.get(context).banners;
                    return buildPicItem(context,list[index]);
                  },
                  separatorBuilder: (context, index) => Container(
                    height: 8,
                  ),
                  itemCount: StoreAppCubit.get(context).banners.length,
                ),
              ],
            ),
          ),
        );
      },
    );  }
}
Widget buildPicItem(context , BannerModel model) => Stack(
  children: [
    Container(
      child: Container(
        width: double.infinity,
        height: 165,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
                model.imageUrl),
          ),
        ),
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
            StoreAppCubit.get(context).removeBanner(model.id);
          },
        ),
      ),
    ),
  ],
);