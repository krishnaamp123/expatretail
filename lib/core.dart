/*
We believe, the class name must be unique. 
If there is a conflicting class name in this file,
it means you have to rename it to something more unique.
*/

//DEPENDENCIES
export 'package:curved_navigation_bar/curved_navigation_bar.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:smooth_page_indicator/smooth_page_indicator.dart';
export 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
export 'package:carousel_slider/carousel_slider.dart';
export 'package:flutter_spinkit/flutter_spinkit.dart';
export 'package:get/get.dart';
export 'package:intl/intl.dart';
export 'package:input_quantity/input_quantity.dart';
export 'package:image_picker/image_picker.dart';
export 'package:path_provider/path_provider.dart';
export 'package:http_parser/http_parser.dart';

//OTHER
export 'package:expatretail/global.dart';
export 'package:expatretail/components/color.dart';
export 'dart:async';

//LANDING PAGE
export 'package:expatretail/a%20draft/landing/view/landing_page.dart';
export 'package:expatretail/a%20draft/landing/data/landing_info.dart';
export 'package:expatretail/a%20draft/landing/data/landing_items.dart';

//AUTH PAGE
export 'package:expatretail/service/token.dart';
export 'package:expatretail/service/auth_service.dart';
export 'package:expatretail/authentication/view/navigation_page.dart';
export 'package:expatretail/authentication/view/navigationsuper_page.dart';
export 'package:expatretail/authentication/view/login_page.dart';
export 'package:expatretail/authentication/controller/login_controller.dart';

//--<< RETAIL APP >>--\\

//DASHBOARD PAGE
export 'package:expatretail/a%20draft/dashboard/view/dashboard_page.dart';

//COMPLAINT PAGE
export 'package:expatretail/service/retail_service/complaint_service.dart';
export 'package:expatretail/zretail_view/complaint/controller/complaint_controller.dart';
export 'package:expatretail/zretail_view/complaint/view/complaint_page.dart';
export 'package:expatretail/zretail_view/complaint/view/complaintbar_page.dart';
export 'package:expatretail/zretail_view/complaint/view/complainthistory_page.dart';

//MENU PAGE
export 'package:expatretail/service/retail_service/customerproduct_service.dart';
export 'package:expatretail/zretail_view/menu/controller/menu_controller.dart';
export 'package:expatretail/zretail_view/menu/view/menu_page.dart';
export 'package:expatretail/zretail_view/menu/view/menudetail_page.dart';
export 'package:expatretail/zretail_view/menu/view/itemholder_page.dart';

//CART PAGE
export 'package:expatretail/service/retail_service/cart_service.dart';
export 'package:expatretail/zretail_view/keranjang/controller/keranjang_controller.dart';
export 'package:expatretail/zretail_view/keranjang/view/keranjang_page.dart';
export 'package:expatretail/zretail_view/keranjang/view/keranjangholder_page.dart';

//ORDER PAGE
export 'package:expatretail/service/retail_service/order_service.dart';
export 'package:expatretail/zretail_view/order/controller/order_controller.dart';
export 'package:expatretail/zretail_view/order/view/order_page.dart';
export 'package:expatretail/zretail_view/order/view/orderholder_page.dart';
export 'package:expatretail/zretail_view/order/view/orderdetail_page.dart';

//PROFILE PAGE
export 'package:expatretail/service/retail_service/profile_service.dart';
export 'package:expatretail/zretail_view/profile/controller/profile_controller.dart';
export 'package:expatretail/zretail_view/profile/view/profile_page.dart';
export 'package:expatretail/zretail_view/profile/view/change_password.dart';

//--<< SUPERMARKET APP >>--\\

//PROFILE RETAIL PAGE
export 'package:expatretail/service/supermarket_service/profileretail_service.dart';
export 'package:expatretail/zsupermarket_view/profile_retail/controller/profileretail_controller.dart';
export 'package:expatretail/zsupermarket_view/profile_retail/view/profileretail_page.dart';
export 'package:expatretail/zsupermarket_view/profile_retail/view/profileretailholder_page.dart';

//STOCK PAGE
export 'package:expatretail/service/supermarket_service/stock_service.dart';
export 'package:expatretail/zsupermarket_view/stock/controller/stock_controller.dart';
export 'package:expatretail/zsupermarket_view/stock/view/stock_page.dart';
export 'package:expatretail/zsupermarket_view/stock/view/stockholder_page.dart';

//HISTORY STOCK PAGE
export 'package:expatretail/zsupermarket_view/history_stock/view/historystock_page.dart';
export 'package:expatretail/zsupermarket_view/history_stock/view/historystockholder_page.dart';
export 'package:expatretail/zsupermarket_view/history_stock/view/historystockdetail_page.dart';

//PROFILE PAGE
export 'package:expatretail/zsupermarket_view/profile/view/profilesuper_page.dart';

//WIDGET
export 'package:expatretail/widget/text_widget.dart';
export 'package:expatretail/widget/textfield_widget.dart';
export 'package:expatretail/widget/passtextfield_widget.dart';
export 'package:expatretail/widget/textfieldcomplaint_widget.dart';
export 'package:expatretail/widget/button_widget.dart';
export 'package:expatretail/widget/appbarcart_widget.dart';
export 'package:expatretail/widget/appbar_widget.dart';
export 'package:expatretail/a%20draft/appbarlogo_widget.dart';
export 'package:expatretail/widget/appbartok_widget.dart';
export 'package:expatretail/widget/appbarprofile_widget.dart';
export 'package:expatretail/widget/appbarlogout_widget.dart';
export 'package:expatretail/widget/appbarstock_widget.dart';
