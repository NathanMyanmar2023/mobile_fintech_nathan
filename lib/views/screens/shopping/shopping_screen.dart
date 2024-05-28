import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nathan_app/views/screens/shopping/product/product_listview_widget.dart';
import '../../../resources/colors.dart';
import '../../Ads_banner/ads_banner_widget.dart';
import 'category/categories_widget.dart';
import 'category/top_category.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({Key? key,}) : super(key: key);

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {

  @override
  Widget build(BuildContext context) {
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
            title:  Text(
              AppLocalizations.of(context)!.shopping,
              style: const TextStyle(
                fontSize: 18,
                color: colorPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoriesWidget(),
            TopCategory(),
          //  ProductListViewWidget(mainTitle: "Top Selling Products", tagName: "top-selling-pp",),
            ProductListViewWidget(mainTitle: "Latest Products", tagName: "latest-pp",),
          ],
        ),
      )
    );
  }
}
