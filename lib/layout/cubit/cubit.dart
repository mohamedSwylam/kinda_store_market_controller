import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:kinda_store_controller/layout/cubit/states.dart';
import 'package:kinda_store_controller/models/banner_model.dart';
import 'package:kinda_store_controller/models/comment_model.dart';
import 'package:kinda_store_controller/models/order_model.dart';
import 'package:kinda_store_controller/models/product_model.dart';
import 'package:kinda_store_controller/modules/add_product_screen/add_product_screen.dart';
import 'package:kinda_store_controller/modules/banners_screen/banner_screen.dart';
import 'package:kinda_store_controller/modules/orders_screen/order_screen.dart';
import 'package:kinda_store_controller/modules/products_screen/delete_product_dialog.dart';
import 'package:kinda_store_controller/modules/products_screen/product_screen.dart';
import 'package:kinda_store_controller/modules/search/search_screen.dart';
import 'package:uuid/uuid.dart';
class StoreAppCubit extends Cubit<StoreAppStates> {
  StoreAppCubit() : super(StoreAppInitialState());

  static StoreAppCubit get(context) => BlocProvider.of(context);




  //////////////////////////////////////////////////////////////////////////////////////////add product Screen


  ///////////upload pickedImage

  File productImage;
  String url = 'https://kisss.cc/wp-content/uploads/2018/07/2761.jpg';
  var picker = ImagePicker();

  Future<void> getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      productImage = File(pickedFile.path);
      uploadImage();
      emit(StoreAppPickedImageSuccessState());
    } else {
      productImage = File(pickedFile.path);
      print('No image selected.');
      emit(StoreAppPickedImageErrorState());
    }
  }

  void uploadImage() {
    emit(UploadImageLoadingState());
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
          emit(UploadPickedImageSuccessState());
          url = value;
          print(value);
        } else {
          url = 'https://kisss.cc/wp-content/uploads/2018/07/2761.jpg';
        }
      }).catchError((error) {
        emit(UploadPickedImageErrorState());
      });
    }).catchError((error) {
      emit(UploadPickedImageErrorState());
    });
  }

  void pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage =
    await picker.getImage(source: ImageSource.camera, imageQuality: 10);
    final pickedImageFile = File(pickedImage.path);
    productImage = pickedImageFile;
    uploadImage();
    emit(StoreAppPickedImageCameraSuccessState());
  }

  void remove() {
    url = 'https://kisss.cc/wp-content/uploads/2018/07/2761.jpg';
    uploadImage();
    emit(StoreAppRemoveImageSuccessState());
  }

  var productTitleController = TextEditingController();
  var productTitleEnController = TextEditingController();
  var productPrice;
  var productDescriptionEnController = TextEditingController();
  var productDescriptionController = TextEditingController();
  String productCategory = 'صنف المنتج';

  var uuid = Uuid();

  void changeCategory(String value) {
    productCategory = value;
    emit(StoreAppChangeProductCategorySuccessState());
  }
  String productCategoryEn = ' صنف المنتج بالانجليزيه';
  void changeCategoryEn(String value) {
    productCategoryEn = value;
    emit(StoreAppChangeProductCategoryEnSuccessState());
  }
  void inputPrice(value) {
    productPrice = value;
    //emit(StoreAppInputPriceSuccessState());
  }
  void createProduct(context) {
    final productId = uuid.v4();
    FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .set({
      'id': productId.toString(),
      'title': productTitleController.text,
      'titleEn': productTitleEnController.text,
      'descriptionEn': productDescriptionEnController.text,
      'description': productDescriptionController.text,
      'price': productPrice,
      'imageUrl': url,
      'productCategoryName': productCategory,
      'productCategoryNameُEn': productCategoryEn,
      'isPopular': true,
    }).then((value) {
      emit(CreateProductSuccessState());
    }).catchError((error) {
      emit(CreateProductErrorState(error.toString()));
    });
  }

///////////////////banner screen
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
  //////////////////////////////////////////////////////////////////////////////////////////// products screen

  List<Product> products = [];

  void getProduct() async {
    emit(GetProductLoadingStates());
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productsSnapshot) {
      products = [];
      productsSnapshot.docs.forEach((element) {
        products.insert(
          0,
          Product(
              id: element.get('id'),
              title: element.get('title'),
              titleEn: element.get('titleEn'),
              descriptionEn: element.get('descriptionEn'),
              productCategoryNameEn: element.get('productCategoryNameُEn'),
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
  //////////////update products
  var productUpdateTitleController = TextEditingController();
  var productUpdateTitleEnController = TextEditingController();
  var productUpdatePrice;
  var productUpdateDescriptionEnController = TextEditingController();
  var productUpdateDescriptionController = TextEditingController();
  String productUpdateCategory = 'صنف المنتج';

  void updateProductCategory({
    String productId,
  }) {
    FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .update({
      'productCategoryName': productCategory,
      'productCategoryNameُEn': productCategoryEn,
    })
        .then((value) {
      getProduct();
      emit(UpdateProductSuccessStates());
    }).catchError((error) {
      emit(UpdateProductErrorStates(error.toString()));
    });
  }
  void updateProductTitle({
    String productId,
  }) {
    FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .update({
      'title': productUpdateTitleController.text,
      'titleEn': productUpdateTitleEnController.text,
    })
        .then((value) {
      getProduct();
      emit(UpdateProductSuccessStates());
    }).catchError((error) {
      emit(UpdateProductErrorStates(error.toString()));
    });
  }
  void updateProductDescription({
    String productId,
  }) {
    FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .update({
      'descriptionEn': productUpdateDescriptionEnController.text,
      'description': productUpdateDescriptionController.text,
    })
        .then((value) {
      getProduct();
      emit(UpdateProductSuccessStates());
    }).catchError((error) {
      emit(UpdateProductErrorStates(error.toString()));
    });
  }
  void updateProductPrice({
    String productId,
  }) {
    FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .update({
      'price': productPrice.toString(),
    })
        .then((value) {
      getProduct();
      emit(UpdateProductSuccessStates());
    }).catchError((error) {
      emit(UpdateProductErrorStates(error.toString()));
    });
  }

  ////////////////////////
  Product findById(String productId) {
    return products.firstWhere((element) => element.id == productId);
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

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////search screen

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
  List<Product> searchList = [];

  List<Product> searchQuery(String searchText) {
    searchList = products
        .where((element) =>
        element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    emit(StoreAppSearchQuerySuccessState());
    return searchList;
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////StoreLayout
  int currentIndex = 0;
  List<Widget> StoreScreens = [
    AddProductScreen(),
    ProductsScreen(),
    SearchScreen(),
    OrdersScreen(),
    BannerScreen(),
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


  /////////////////////////////////////////////////////////////////////////////////////// login Screen

  IconData prefix = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    prefix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(PasswordVisibilityState());
  }

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

  ////////////////////////////////////////////////////////////////////////////// orders Screen


  List<OrderModel> orders = [];

  void getOrders() async {
    emit(GetOrdersLoadingStates());
    await FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((QuerySnapshot productsSnapshot) {
      orders = [];
      productsSnapshot.docs.forEach((element) {
        orders.insert(
          0,
          OrderModel(
            orderId: element.get('orderId'),
            title: element.get('title'),
            titleEn: element.get('titleEn'),
            imageUrl: element.get('imageUrl'),
            products: element.get('products'),
            prices: element.get('prices'),
            quantities : element.get('quantities'),
            productsEn: element.get('productsEn'),
            userId: element.get('userId'),
            userAddress: element.get('userAddress'),
            total: element.get('total'),
            subTotal: element.get('subTotal'),
            anotherNumber: element.get('anotherNumber'),
            addressDetails: element.get('addressDetails'),
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

  //////////Comment
  List<CommentModel> comments = [];
  void getComments(
      @required String productId,
      ) async {
    emit(GetCommentsLoadingStates());
    await FirebaseFirestore.instance
        .collection('products').doc(productId).collection('comments').
    get()
        .then((QuerySnapshot commentsSnapshot) {
      comments.clear();
      commentsSnapshot.docs.forEach((element) {
        // print('element.get(productBrand), ${element.get('productBrand')}');
        comments.insert(
          0,
          CommentModel(
            userId: element.get('userId'),
            dateTime: element.get('dateTime'),
            commentId: element.get('commentId'),
            imageUrl: element.get('imageUrl'),
            username: element.get('username'),
            rate: element.get('rate'),
            rateDescription: element.get('rateDescription'),
            rateDescriptionEn: element.get('rateDescriptionEn'),
            productId: element.get('productId'),
            text: element.get('text'),
          ),
        );
      });
      emit(GetCommentsSuccessStates());
    }).catchError((error) {
      emit(GetCommentsErrorStates());
    });
  }
  double rate ;
  String rateDescription;
  String rateDescriptionEn;
  void changeRating(rating) {
    rate=rating;
    if (rating > 0 && rating <= 1){
      rateDescription ='سئ';
      rateDescriptionEn ='Bad';
    }
    else if (rating > 1 && rating <= 2){
      rateDescription ='لم يعجبني';
      rateDescriptionEn ='Dislike';
    }
    else if (rating > 2 && rating <=3){
      rateDescription ='جيد';
      rateDescriptionEn ='Good';
    }
    else if (rating > 3 && rating <= 4){
      rateDescription ='ممتاز';
      rateDescriptionEn ='Excellent';
    }
    else if (rating > 4 && rating <= 5){
      rateDescription ='رائع';
      rateDescriptionEn ='Amazing';
    }
    else{
      rate =3.0;
      rateDescription="جيد";
      rateDescriptionEn ='Good';
    }
    print(rating);
    emit(ChangeRateSuccessStates());
  }

  void removeComment(productId,commentId) async {
    emit(RemoveCommentLoadingStates());
    await FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .collection('comments')
        .doc(commentId)
        .delete()
        .then((_) {
      emit(RemoveCommentSuccessStates());
    }).catchError((error) {
      emit(RemoveCommentErrorStates());
    });
  }
}





