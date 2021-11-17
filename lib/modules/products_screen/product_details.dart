import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:kinda_store_controller/layout/cubit/cubit.dart';
import 'package:kinda_store_controller/layout/cubit/states.dart';
import 'package:kinda_store_controller/models/comment_model.dart';
import 'package:kinda_store_controller/shared/components/components.dart';
import 'package:kinda_store_controller/styles/colors/colors.dart';
import 'package:sizer/sizer.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;
  const ProductDetailsScreen({this.productId});
  @override
  Widget build(BuildContext context) {
    var commentController = TextEditingController();
    var date = DateTime.now().toString();
    var dateparse = DateTime.parse(date);
    var formattedDate = "${dateparse.day}-${dateparse.month}-${dateparse.year}";
    StoreAppCubit.get(context).getComments(productId);
    return BlocConsumer<StoreAppCubit, StoreAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var productAttr = StoreAppCubit.get(context).findById(productId);
        var cubit = StoreAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 1,
            actions: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 11),
                child: Text(
                  'تفاصيل المنتج',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              )
            ],
          ),
          body: Stack(
            children: [
              Container(
                foregroundDecoration: BoxDecoration(
                  color: Colors.black12,
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.38,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(productAttr.imageUrl),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 240.0,
                    bottom: 0.0,
                  ),
                  child: Column(
                    children: [
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 4.h,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                productAttr.title,
                                maxLines: 3,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontSize: 20.sp),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'ج.م',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 17.sp),
                                  ),
                                  Text(
                                    '${productAttr.price.toStringAsFixed(0)}',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 17.sp),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            myDivider(),
                            SizedBox(
                              height: 2.h,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                productAttr.description,
                                maxLines: 15,
                                textAlign: TextAlign.end,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(fontSize: 13.sp),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            myDivider(),
                            SizedBox(
                              height: 2.h,
                            ),
                            myDivider(),
                            SizedBox(
                              height: 2.h,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Text(
                                      'تقييم المنتج',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp,
                                              color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 40.h,
                                      child: ListView.separated(
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            var list =
                                                StoreAppCubit.get(context)
                                                    .comments;
                                            return buildCommentItem(
                                              context,
                                              list[index],
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                                height: 0.h,
                                              ),
                                          itemCount: StoreAppCubit.get(context)
                                              .comments
                                              .length),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget buildCommentItem(context, CommentModel model) {
  var cubit = StoreAppCubit.get(context);
  return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 60.w,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          '${model.username}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(fontSize: 14.sp),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 18.w,
                            height: 6.7.h,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.yellow[700],
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${model.rate}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 0.w),
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 5.w,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "المنتج",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(fontSize: 12.sp, color: Colors.black),
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '${model.rateDescription}',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(fontSize: 12.sp, color: defaultColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            '${model.text} ',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(fontSize: 12.sp, color: defaultColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 8.w,
                  backgroundImage: NetworkImage('${model.imageUrl}'),
                ),
              ],
            ),
            Positioned(
              child: Container(
                height: 5.h,
                width: 8.w,
                child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    padding: EdgeInsets.symmetric(horizontal: 0.0),
                    color: Colors.redAccent,
                    child: Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 6.w,
                    ),
                    onPressed:(){
                      StoreAppCubit.get(context).removeComment(model.productId, model.commentId);
                      StoreAppCubit.get(context).getComments(model.productId);
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

