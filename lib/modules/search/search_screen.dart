import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:badges/badges.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:kinda_store_controller/layout/cubit/cubit.dart';
import 'package:kinda_store_controller/models/product_model.dart';
import 'package:kinda_store_controller/styles/colors/colors.dart';




class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchTextController;
  final FocusNode _node = FocusNode();
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _searchTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _node.dispose();
    _searchTextController.dispose();
  }
  List<Product> _searchList = [];
  List<Product> searchQuery(String searchText) {
    List _searchList = StoreAppCubit.get(context).products
        .where((element) =>
        element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return _searchList;
  }
  @override
  Widget build(BuildContext context) {
    final productsList = StoreAppCubit().products;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[300],
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 9),
            child: Text(
              "البحث",
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
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 40.0, vertical: 20),
              child: Container(
                child: TextFormField(
                  textAlign: TextAlign.end,
                  onTap: () {},
                  controller: _searchTextController,
                  minLines: 1,
                  focusNode: _node,
                  cursorHeight: 20,
                  onChanged: (String enteredKeyword) {
                    List<Product> result = [];
                    if (enteredKeyword.isEmpty) {
                      // if the search field is empty or only contains white-space, we'll display all products
                      result = StoreAppCubit.get(context).products;
                    } else {
                      result = StoreAppCubit.get(context).products .where((element) =>
                          element.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
                          .toList();
                      // we use the toLowerCase() method to make it case-insensitive
                    }
                    // Refresh the UI
                    setState(() {
                      _searchList = result;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "ابحث في المتجر",
                    fillColor: Colors.white,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Feather.search),
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: _searchTextController.text.isEmpty
                          ? null
                          : () {
                        _searchTextController.clear();
                        _node.unfocus();
                      },
                      icon: Icon(Feather.x,
                          color: _searchTextController.text.isNotEmpty
                              ? Colors.red
                              : Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                  ),
                ),
              ),
            ),
            Container(
              child: _searchTextController.text.isNotEmpty && _searchList.isEmpty
                  ? Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Icon(
                    Feather.search,
                    size: 60,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'لا توجد نتائج',
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                ],
              )
                  : GridView.count(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 240 / 420,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: List.generate(
                    _searchTextController.text.isEmpty
                        ? productsList.length
                        : _searchList.length, (index) {
                  return buildSearchItem(context, _searchList[index]);
                }),
              ),
            ),
          ],
        ),

      ),
    );

  }

  Widget buildSearchItem(context, Product model) =>
      InkWell(
        onTap: ()  {

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
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        model.title, style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ج.م',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(width: 5,),
                        Text(
                          '${model.price}',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
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
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        StoreAppCubit.get(context).removeProductFromSearch(model.id,context);
                      },
                      child: Icon( Feather.trash,),
                    ),

                  ],
                ),
              ),
            ],

          ),

        ),
      );
}