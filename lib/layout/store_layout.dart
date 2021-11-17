import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class StoreLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit, StoreAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = StoreAppCubit.get(context);
        return Scaffold(
          body: cubit.StoreScreens[cubit.currentIndex],
          bottomNavigationBar: TitledBottomNavigationBar(
            activeColor: Colors.yellowAccent[700],
            onTap: (index) => cubit.changeIndex(index),
            currentIndex: cubit.currentIndex,
            items: [
              TitledNavigationBarItem(title: Text('الاضافه',style: Theme.of(context).textTheme.subtitle1,), icon: MaterialCommunityIcons.plus,),
              TitledNavigationBarItem(title: Text('المنتجات',style: Theme.of(context).textTheme.subtitle1,), icon: Feather.rss,),
              TitledNavigationBarItem(title: Text('البحث',style: Theme.of(context).textTheme.subtitle1,), icon: Feather.search,),
              TitledNavigationBarItem(title: Text('الطلبات',style: Theme.of(context).textTheme.subtitle1,), icon: Icons.view_compact_rounded,),
              TitledNavigationBarItem(title: Text('الصور',style: Theme.of(context).textTheme.subtitle1,), icon: Icons.image,),
            ],
          ),
        );
      },
    );
  }
}
