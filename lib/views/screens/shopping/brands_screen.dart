import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fnge/bloc/shopping/brands_bloc.dart';
import 'package:fnge/objects/brands_ob.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../helpers/response_ob.dart';
import '../../../pages/cart_page.dart';
import '../../../pages/order_list_page.dart';
import '../../../pages/shopping_page.dart';
import '../../../resources/colors.dart';
import '../../../widgets/app_bar_title_view.dart';
import '../../Ads_banner/ads_banner_widget.dart';

class BrandsScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  const BrandsScreen(
      {Key? key, required this.categoryId, required this.categoryName})
      : super(key: key);

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  final _brandsBloc = BrandsBloc();
  late Stream<ResponseOb> _brandsStream;
  List<BrandData> brandsList = [];

  @override
  void initState() {
    super.initState();
    _brandsStream = _brandsBloc.brandsStream();
    _brandsStream.listen((ResponseOb resp) {
      brandsList.add(BrandData(
          id: 0,
          name: "All",
          photo:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6QF8VXMSxOoe3b3lf9GLaB0idx5u_9AWpKvnCM-odNxfFtDHczv2o7_-mOiLDaHb21qw&usqp=CAU"));
      if (resp.success) {
        setState(() {
          // brandsList = (resp.data as BrandsOb).data ?? [];
          brandsList.addAll((resp.data as BrandsOb).data ?? []);
        });
      } else {}
    });

    _brandsBloc.getBrandsList(widget.categoryId);
  }

  int selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(
            toolbarHeight: 70,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: colorPrimary,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              "${widget.categoryName} / ${AppLocalizations.of(context)!.brand}",
              style: const TextStyle(
                fontSize: 18,
                color: colorPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const OrderListPage(),
                  ));
                },
                child: const Icon(
                  Icons.list,
                  color: colorPrimary,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ));
                },
                child: const Icon(
                  Icons.shopping_cart_rounded,
                  color: colorPrimary,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
            ],
          ),
        ),
      ),
      body: brandsList.isEmpty
          ? Center(
              child: Text(
                AppLocalizations.of(context)!.no_more_data,
              ),
            )
          : DefaultTabController(
              length: brandsList.length,
              child: Container(
                color: colorWhite,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Theme(
                          data: theme.copyWith(
                            colorScheme: theme.colorScheme.copyWith(
                              surfaceVariant: Colors.transparent,
                            ),
                          ),
                          child: TabBar(
                            onTap: (tabIndex) {
                              setState(() {
                                selectedItem = tabIndex;
                              });
                            },
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            padding: EdgeInsets.zero,
                            indicatorPadding: EdgeInsets.zero,
                            labelPadding: EdgeInsets.zero,
                            labelColor: colorPrimary,
                            labelStyle: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                            unselectedLabelStyle: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 13),
                            unselectedLabelColor: colorBlack,
                            indicatorColor: colorWhite,
                            indicatorWeight: 0.1,
                            tabs: List.generate(brandsList.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: SizedBox(
                                  height: 120,
                                  width: 60,
                                  child: Tab(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 27, // Image
                                        backgroundColor: selectedItem == index
                                            ? colorPrimary
                                            : colorSeconary,
                                        child: CircleAvatar(
                                          radius: 25, // Image radius
                                          backgroundColor: colorSeconary,
                                          backgroundImage: NetworkImage(
                                              brandsList[index].photo ?? ""),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        brandsList[index].name ?? "",
                                      ),
                                    ],
                                  )),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      //  const Center(child: AdsBannerWidget(paddingbottom: 10, paddingTop: 0,)),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children:
                                List.generate(brandsList.length, (indexView) {
                              return ShoppingPage(
                                brandId: brandsList[indexView].id,
                                categoryId: widget.categoryId,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      // SizedBox(height: 2.h,),
                    ]),
              )),
    );
  }
}
