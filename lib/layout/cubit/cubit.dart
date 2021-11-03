import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:kinda_store_controller/layout/cubit/states.dart';
import 'package:kinda_store_controller/local/cache_helper.dart';
import 'package:kinda_store_controller/models/banner_model.dart';
import 'package:kinda_store_controller/models/category_model.dart';
import 'package:kinda_store_controller/models/order_model.dart';
import 'package:kinda_store_controller/models/product_model.dart';
import 'package:kinda_store_controller/modules/Login_screen/login_screen.dart';
import 'package:kinda_store_controller/modules/cart_screen/cart_screen.dart';
import 'package:kinda_store_controller/modules/feeds_screen/delete_product_dialog.dart';
import 'package:kinda_store_controller/modules/feeds_screen/feeds_screen.dart';
import 'package:kinda_store_controller/modules/home_screen/home_screen.dart';
import 'package:kinda_store_controller/modules/search/search_screen.dart';
import 'package:kinda_store_controller/modules/user_screen/user_screen.dart';
import 'package:kinda_store_controller/shared/components/components.dart';
import 'package:uuid/uuid.dart';
class StoreAppCubit extends Cubit<StoreAppStates> {
  StoreAppCubit() : super(StoreAppInitialState());

  static StoreAppCubit get(context) => BlocProvider.of(context);


  bool isDark = false;

  void changeThemeMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(StoreAppChangeThemeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {});
      emit(StoreAppChangeThemeModeState());
    }
  }

  void changeThemeModeToDark({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(StoreAppChangeThemeModeState());
    } else {
      isDark = true;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {});
      emit(StoreAppChangeThemeModeState());
    }
  }

  void changeThemeModeToLight({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(StoreAppChangeThemeModeState());
    } else {
      isDark = false;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {});
      emit(StoreAppChangeThemeModeState());
    }
  }

  File productImage;
  String url = 'https://kisss.cc/wp-content/uploads/2018/07/2761.jpg';
  var picker = ImagePicker();

  Future<void> getProfileImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      productImage = File(pickedFile.path);
      uploadProfileImage();
      emit(StoreAppPickedProfileImageSuccessState());
    } else {
      productImage = File(pickedFile.path);
      print('No image selected.');
      emit(StoreAppPickedProfileImageErrorState());
    }
  }

  void uploadProfileImage() {
    emit(UploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('products/${Uri
        .file(productImage.path)
        .pathSegments
        .last}')
        .putFile(productImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        if (value != null) {
          emit(UploadPickedProfileImageSuccessState());
          url = value;
          print(value);
        } else {
          url = 'https://kisss.cc/wp-content/uploads/2018/07/2761.jpg';
        }
      }).catchError((error) {
        emit(UploadPickedProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadPickedProfileImageErrorState());
    });
  }

  void pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage =
    await picker.getImage(source: ImageSource.camera, imageQuality: 10);
    final pickedImageFile = File(pickedImage.path);
    productImage = pickedImageFile;
    uploadProfileImage();
    emit(StoreAppPickedProfileImageCameraSuccessState());
  }

  void remove() {
    url = 'https://kisss.cc/wp-content/uploads/2018/07/2761.jpg';
    uploadProfileImage();
    emit(StoreAppRemoveProfileImageSuccessState());
  }

  var productTitleController = TextEditingController();
  var productPrice;
  var productDescriptionController = TextEditingController();
  String productCategory = 'صنف المنتج';

  var uuid = Uuid();

  void changeCategory(String value) {
    productCategory = value;
    emit(StoreAppChangeUploadProductCategorySuccessState());
  }

  void inputPrice(value) {
    productPrice = value;
    emit(StoreAppInputPriceSuccessState());
  }
///////////////////banner
  void uploadBanner(context) {
    final bannerId = uuid.v4();
    FirebaseFirestore.instance
        .collection('banners')
        .doc(bannerId)
        .set({
      'id': bannerId.toString(),
      'imageUrl': url,
    }).then((value) {
      getBanners();
      emit(CreateBannerSuccessState());
    }).catchError((error) {
      emit(CreateBannerErrorState(error.toString()));
    });
  }
  List<BannerModel> banners = [];
  void getBanners() async {
    emit(GetBannersLoadingStates());
    await FirebaseFirestore.instance
        .collection('banners')
        .get()
        .then((QuerySnapshot bannersSnapshot) {
      banners = [];
      bannersSnapshot.docs.forEach((element) {
        // print('element.get(productBrand), ${element.get('productBrand')}');
        banners.insert(
          0,
            BannerModel(
              id: element.get('id'),
              imageUrl: element.get('imageUrl'),),
        );
      });
      emit(GetBannersSuccessStates());
    }).catchError((error) {
      emit(GetBannersErrorStates(error.toString()));
    });
  }
  void removeBanner(bannerId) async {
    emit(RemoveBannerLoadingStates());
    await FirebaseFirestore.instance
        .collection('banners')
        .doc(bannerId).delete()
        .then((_) {
      getBanners();
      emit(RemoveBannerSuccessStates());
    }).catchError((error) {
      emit(RemoveBannerErrorStates());
    });
  }
  ////////////////////
  void createProduct(context) {
    final productId = uuid.v4();
    FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .set({
      'id': productId.toString(),
      'title': productTitleController.text,
      'description': productDescriptionController.text,
      'price': productPrice,
      'imageUrl': url,
      'productCategoryName': productCategory,
      'isPopular': true,
    }).then((value) {
      emit(CreateProductSuccessState());
    }).catchError((error) {
      emit(CreateProductErrorState(error.toString()));
    });
  }

  List<Product> products = [];

  void getProduct() async {
    emit(GetProductLoadingStates());
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productsSnapshot) {
      products = [];
      productsSnapshot.docs.forEach((element) {
        // print('element.get(productBrand), ${element.get('productBrand')}');
        products.insert(
          0,
          Product(
              id: element.get('id'),
              title: element.get('title'),
              description: element.get('description'),
              price: double.parse(
                element.get('price'),
              ),
              imageUrl: element.get('imageUrl'),
              productCategoryName: element.get('productCategoryName'),
              isPopular: true),
        );
      });
      emit(GetProductSuccessStates());
    }).catchError((error) {
      emit(GetProductErrorStates(error.toString()));
    });
  }

  void removeProduct(productId) async {
    emit(RemoveProductLoadingStates());
    await FirebaseFirestore.instance
        .collection('products')
        .doc(productId).delete()
        .then((_) {
      getProduct();
      emit(RemoveProductSuccessStates());
    }).catchError((error) {
      emit(RemoveProductErrorStates());
    });
  }

  void removeProductFromSearch(productId, context) async {
    emit(RemoveProductFromSearchLoadingStates());
    await FirebaseFirestore.instance
        .collection('products')
        .doc(productId).delete()
        .then((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) => DeleteProductDialog(),
      );
      getProduct();
      emit(RemoveProductFromSearchSuccessStates());
    }).catchError((error) {
      emit(RemoveProductFromSearchErrorStates());
    });
  }

  /////////////////////////////////////////////////
  int currentIndex = 0;
  List<Widget> StoreScreens = [
    HomeScreen(),
    FeedsScreen(),
    SearchScreen(),
    CartScreen(),
    UserScreen(),
  ];

  void selectedHome() {
    currentIndex = 0;
    emit(StoreAppBottomBarHomeState());
  }

  void selectedFeed() {
    currentIndex = 1;
    emit(StoreAppBottomBarFeedState());
  }

  void selectedCart() {
    currentIndex = 3;
    emit(StoreAppBottomBarCartState());
  }


  void changeIndex(int index) {
    currentIndex = index;
    emit(StoreChangeBottomNavState());
  }

  String dropDownValue = '1';
  var items = ['1', '2', '3', '4', '5', '6'];

  void changeDropDownValue(String newValue) {
    dropDownValue = newValue;
    emit(StoreChangeDropdownState());
  }

  ///////////////////////////SignUp


  IconData prefix = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    prefix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(SignUpPasswordVisibilityState());
  }


  ///////////////////////////// login Screen
  void userLogin({
    @required String password,
    @required String email,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      getUserData();
      getOrders();
      print(value.user.email);
      print(value.user.uid);
      emit(LoginSuccessState(value.user.uid));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  void userForgetPassword({
    @required String email,
  }) {
    emit(ForgetPasswordLoadingState());
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: email.trim().toLowerCase())
        .then((value) {
      emit(ForgetPasswordSuccessState());
    }).catchError((error) {
      emit(ForgetPasswordErrorState(error.toString()));
    });
  }


  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name;
  String phone;

  String email;
  String uId;
  String profileImage;
  String address;
  String joinedAt;
  String createdAt;

  void getUserData() async {
    emit(GetUserLoginLoadingStates());
    User user = _auth.currentUser;
    uId = user.uid;
    print('user.displayName ${user.displayName}');
    print('user.photoURL ${user.photoURL}');
    final DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection('users').doc(uId).get();
    if (userDoc == null) {
      return;
    } else {
      name = userDoc.get('name');
      email = user.email;
      joinedAt = userDoc.get('joinedAt');
      phone = userDoc.get('phone');
      address = userDoc.get('address');
      profileImage = userDoc.get('profileImage');
      createdAt = userDoc.get('createdAt');
      emit(GetUserLoginSuccessStates());
    }
  }

  ///////////
  List<OrderModel> orders = [];

  void getOrders() async {
    emit(GetOrdersLoadingStates());
    await FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((QuerySnapshot productsSnapshot) {
      orders = [];
      productsSnapshot.docs.forEach((element) {
        // print('element.get(productBrand), ${element.get('productBrand')}');
        orders.insert(
          0,
          OrderModel(
            orderId: element.get('orderId'),
            title: element.get('title'),
            price: element.get('price'),
            imageUrl: element.get('imageUrl'),
            userId: element.get('userId'),
            userAddress: element.get('userAddress'),
            total: element.get('total'),
            subTotal: element.get('subTotal'),
            anotherNumber: element.get('anotherNumber'),
            addressDetails: element.get('addressDetails'),
            quantity: element.get('quantity'),
            productId: element.get('productId'),
            username: element.get('username'),
            userPhone: element.get('userPhone'),
          ),
        );
      });
      emit(GetOrdersSuccessStates());
    }).catchError((error) {
      emit(GetOrdersErrorStates());
    });
  }

  void removeOrder(orderId) async {
    emit(RemoveOrderLoadingStates());
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .delete()
        .then((_) {
      getOrders();
      emit(RemoveOrderSuccessStates());
    }).catchError((error) {
      emit(RemoveOrderErrorStates());
    });
  }

  /////////


  /////////////////////////search
  List<Product> searchList = [];

  List<Product> searchQuery(String searchText) {
    searchList = products
        .where((element) =>
        element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    emit(StoreAppSearchQuerySuccessState());
    return searchList;
  }

  ///////////////////////////////////Signout
  void signOut(context) =>
      CacheHelper.removeData(key: 'uId').then((value) {
        if (value) {
          FirebaseAuth.instance
              .signOut()
              .then((value) => navigateAndFinish(context, LoginScreen()));
          emit(SignOutSuccessState());
        }
      });

  ////////////////////////////////categoryScreen
  List<CategoryModel> categories = [
    CategoryModel(
        categoryName: 'توابل', categoryImage: 'assets/images/twabl.jpg'),
    CategoryModel(
        categoryName: 'مجمدات', categoryImage: 'assets/images/mogmdat.jpg'),
    CategoryModel(
        categoryName: 'مشروبات', categoryImage: 'assets/images/mshrob.jpg'),
    CategoryModel(
        categoryName: 'مثلجات', categoryImage: 'assets/images/moslgat.jpg'),
    CategoryModel(
      categoryName: 'جبن', categoryImage: 'assets/images/cheese.jpg',),
    CategoryModel(
        categoryName: 'صوصات', categoryImage: 'assets/images/sos.jpg'),
    CategoryModel(
        categoryName: 'مخبوزات', categoryImage: 'assets/images/bread.jpg'),
    CategoryModel(
      categoryName: 'شيكولاته', categoryImage: 'assets/images/choclate.jpg',),
    CategoryModel(
        categoryName: 'حلوي', categoryImage: 'assets/images/halwa.jpeg'),
    CategoryModel(
        categoryName: 'مكسرات', categoryImage: 'assets/images/mksrat.gif'),
    CategoryModel(
        categoryName: 'بقاله', categoryImage: 'assets/images/bkala.jpg'),
  ];

}

////////////////banner
