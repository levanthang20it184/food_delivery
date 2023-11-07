import 'package:get/get.dart';
class Dimensions{
  //screenHeight=732
  //screenWidth=360
static double screenHeight = Get.context!.height;
static double screenWidth = Get.context!.width;
static double pageView = screenHeight/2.28;
static double pageViewContainer = screenHeight/3.299;
static double pageViewTextContainer = screenHeight/6.1;
// dynamic height padding and margin
static double height10 = screenHeight/73.2;
static double height20 = screenHeight/36.6;
static double height15 = screenHeight/48.9;
static double height30 = screenHeight/24.4;
static double height45 = screenHeight/15.9999;

// dynamic width padding and margin
static double width10 = screenWidth/36;
static double width15 = screenWidth/24;
static double width20 = screenWidth/18;
static double width30 = screenWidth/12;
static double width45 = screenWidth/8;
// Icon size
static double iconsize24 = screenHeight/29.9999;
static double iconsize16 = screenHeight/45.75;

static double sizetext = screenHeight/24.4;


static double font20 = screenHeight/36.6;
static double font16 = screenHeight/45.75;
static double font26 = screenHeight/28.15;


static double radius15 = screenHeight/48.9;
static double radius20 = screenHeight/36.6;
static double radius30 = screenHeight/24.4;

// list view size
static double ListViewImgsSize = screenHeight/6.1;
static double ListViewImgsSize100 = screenHeight/7.32;

static double ListViewTextContSize = screenHeight/7.32;

// popular food
static double popularFoodImagSize = screenHeight/2.09;

// bottom height
static double bottomHeightBar = screenHeight/6.1;
}