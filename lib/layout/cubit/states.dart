abstract class StoreAppStates {}

class StoreAppInitialState extends StoreAppStates {}

//changeTheme
class StoreAppChangeThemeModeState extends StoreAppStates {}

//search
class StoreAppSearchQuerySuccessState extends StoreAppStates {}

//pickedImage
class StoreAppPickedImageSuccessState extends StoreAppStates {}

class StoreAppPickedImageErrorState extends StoreAppStates {}

//upload Image from gallery
class UploadImageLoadingState extends StoreAppStates {}

class UploadPickedImageSuccessState extends StoreAppStates {}

class UploadPickedImageErrorState extends StoreAppStates {}

//upload Image from camera
class StoreAppPickedImageCameraSuccessState extends StoreAppStates {}

//upload Image from gallery
class StoreAppRemoveImageSuccessState extends StoreAppStates {}

//Change Product Category
class StoreAppChangeProductCategorySuccessState extends StoreAppStates {}
class StoreAppChangeProductCategoryEnSuccessState extends StoreAppStates {}

//Create Product
class CreateProductSuccessState extends StoreAppStates {}

class CreateProductErrorState extends StoreAppStates {
  final String error;

  CreateProductErrorState(this.error);
}

//Create banner
class CreateBannerSuccessState extends StoreAppStates {}

class CreateBannerErrorState extends StoreAppStates {
  final String error;

  CreateBannerErrorState(this.error);
}

//get Product
class GetProductLoadingStates extends StoreAppStates {}

class GetProductSuccessStates extends StoreAppStates {}

class GetProductErrorStates extends StoreAppStates {
  final String error;

  GetProductErrorStates(this.error);
}

//get banner
class GetBannersLoadingStates extends StoreAppStates {}

class GetBannersSuccessStates extends StoreAppStates {}

class GetBannersErrorStates extends StoreAppStates {
  final String error;

  GetBannersErrorStates(this.error);
}

//Remove Product From Search Screen

class RemoveProductFromSearchLoadingStates extends StoreAppStates {}

class RemoveProductFromSearchSuccessStates extends StoreAppStates {}

class RemoveProductFromSearchErrorStates extends StoreAppStates {}

//Remove Banner image
class RemoveBannerLoadingStates extends StoreAppStates {}

class RemoveBannerSuccessStates extends StoreAppStates {}

class RemoveBannerErrorStates extends StoreAppStates {}

//Remove Product
class RemoveProductLoadingStates extends StoreAppStates {}

class RemoveProductSuccessStates extends StoreAppStates {}

//Remove order
class RemoveOrderLoadingStates extends StoreAppStates {}

class RemoveOrderSuccessStates extends StoreAppStates {}

class RemoveOrderErrorStates extends StoreAppStates {}

// Input Price
class StoreAppInputPriceSuccessState extends StoreAppStates {}

class RemoveProductErrorStates extends StoreAppStates {}

//Change Bottom Navigation bar

class StoreChangeBottomNavState extends StoreAppStates {}

class StoreChangeDropdownState extends StoreAppStates {}

//select specific page

class StoreAppBottomBarHomeState extends StoreAppStates {}

class StoreAppBottomBarFeedState extends StoreAppStates {}

class StoreAppBottomBarCartState extends StoreAppStates {}

////////////get order
class GetOrdersLoadingStates extends StoreAppStates {}

class GetOrdersSuccessStates extends StoreAppStates {}

class GetOrdersErrorStates extends StoreAppStates {}

/////////////////loginScreen

class LoginInitialState extends StoreAppStates {}

class LoginLoadingState extends StoreAppStates {}

class LoginSuccessState extends StoreAppStates {
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends StoreAppStates {
  final String error;

  LoginErrorState(this.error);
}

class ForgetPasswordLoadingState extends StoreAppStates {}

class ForgetPasswordSuccessState extends StoreAppStates {}

class ForgetPasswordErrorState extends StoreAppStates {
  final String error;

  ForgetPasswordErrorState(this.error);
}

class GetUserLoginLoadingStates extends StoreAppStates {}

class GetUserLoginSuccessStates extends StoreAppStates {}

class GetUserLoginErrorStates extends StoreAppStates {}


class PasswordVisibilityState extends StoreAppStates {}
///////////////comment
class GetCommentsLoadingStates extends StoreAppStates {}

class GetCommentsSuccessStates extends StoreAppStates {}

class GetCommentsErrorStates extends StoreAppStates {}

class ChangeRateSuccessStates extends StoreAppStates {}

class RemoveCommentLoadingStates extends StoreAppStates {}
class RemoveCommentSuccessStates extends StoreAppStates {}
class RemoveCommentErrorStates extends StoreAppStates {}

