import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:laundry/gen/assets.gen.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/main_screen/active_orders/view/active_orders_screen.dart';
import 'package:laundry/views/main_screen/home_screen/view/home_screen.dart';
import 'package:laundry/views/main_screen/home_screen/view/widgets/home_screen_shimmer.dart';
import 'package:laundry/views/main_screen/home_screen/view_model/home_view_model.dart';
import 'package:laundry/views/main_screen/past_orders/view/past_orders_screen.dart';
import 'package:laundry/views/main_screen/whatsapp_share/whatsapp.dart';
import 'package:laundry/views/manage_address/view_model/manage_address_view_model.dart';
import 'package:laundry/views/profile/profile.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final ScrollController homeScrollController;
  late final ValueNotifier<int> selectedIndex;
  DateTime? currentBackPressTime;
  late final PageController pageController;
  late final ValueNotifier<bool> isAppBarScrolled;
  late HomeProvider homeProvider;

  @override
  void initState() {
    homeProvider = context.read<HomeProvider>();
    homeProvider.getServices();
    context.read<ManageAddressProvider>().getCurrentLocation();
    selectedIndex = ValueNotifier(2);
    pageController = PageController(initialPage: 2, keepPage: true);
    homeScrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (context, value, child) {
          return Scaffold(
            body: Consumer<HomeProvider>(
              builder: (context, value, child) {
                switch (value.loaderState) {
                  case LoaderState.loading:
                    return const Center(child: HomeScreenShimmer());
                  case LoaderState.loaded:
                    return PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageController,
                      children: const [
                        PastOrdersScreen(),
                        Whatsapp(),
                        // SizedBox(),
                        // ManageAddressScreen(),
                        HomeScreen(),
                        ActiveOrdersScreen(),
                        Profile(),
                        // SizedBox()
                        // ManageAddressScreen(),
                      ],
                    );
                  case LoaderState.error:
                    return Center(
                      child: Text('Oops...! Error',
                          style: FontPalette.poppinsBold),
                    );
                  case LoaderState.noData:
                    return Center(
                      child: Text(
                        'No Data Found',
                        style: FontPalette.poppinsBold,
                      ),
                    );
                  case LoaderState.noProducts:
                    return Center(
                      child: Text(
                        'No Data Found',
                        style: FontPalette.poppinsBold,
                      ),
                    );
                  case LoaderState.networkErr:
                    return Center(
                      child: Text(
                        'Network Error',
                        style: FontPalette.poppinsBold,
                      ),
                    );
                }
              },
            ),
            bottomNavigationBar: CurvedNavigationBar(
              index: 2,
              animationCurve: Curves.easeInOutSine,
              height: 75,
              color: ColorPalette.primaryColor,
              backgroundColor: Colors.white,
              items: <Widget>[
                Center(
                    child: Center(
                        child: Container(
                            height: 30,
                            width: 30,
                            padding: const EdgeInsets.all(1),
                            child: Assets.icons.order.image(
                                height: 30,
                                width: 30,
                                fit: BoxFit.fill,
                                color: Colors.white)))),
                Center(
                    child: Assets.icons.whatsapp.image(
                        height: 30,
                        width: 30,
                        fit: BoxFit.fill,
                        color: Colors.white)),
                Center(
                    child: Center(
                        child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Assets.icons.home.image(
                              height: 20,
                              width: 20,
                              fit: BoxFit.fill,
                            )))),
                Center(
                    child: Assets.icons.activeOrders.image(
                        height: 30,
                        width: 30,
                        fit: BoxFit.fill,
                        color: Colors.white)),
                Center(
                    child: Assets.icons.settings.image(
                        height: 30,
                        width: 30,
                        fit: BoxFit.fill,
                        color: Colors.white)),
              ],
              onTap: (index) {
                onBottomNavTap(index);
              },
            ),
          );
        });
  }

  void onBottomNavTap(int val) {
    switch (val) {
      case 0:
        if (selectedIndex.value != 0) {
          updateSelectedIndex(val, onMainTap: true);
        }
        break;
      case 1:
        updateSelectedIndex(val, onMainTap: true);
        break;
      case 2:
        updateSelectedIndex(val, onMainTap: true);
        break;
      case 3:
        updateSelectedIndex(val, onMainTap: true);
        break;
      case 4:
        updateSelectedIndex(val, onMainTap: true);
        break;
    }
  }

  void updateSelectedIndex(int index, {bool onMainTap = false}) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
}
