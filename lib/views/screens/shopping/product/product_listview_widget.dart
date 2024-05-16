import 'package:flutter/material.dart';
import 'package:nathan_app/views/screens/shopping/product/product_card_component.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../bloc/shopping_bloc.dart';
import '../../../../helpers/response_ob.dart';
import '../../../../objects/shopping_ob.dart';
import '../../../../resources/colors.dart';
import '../../../../widgets/nathan_text_view.dart';

class ProductListViewWidget extends StatefulWidget {
  final String mainTitle;
  final String tagName;
  const ProductListViewWidget({Key? key, required this.mainTitle, required this.tagName}) : super(key: key);

  @override
  State<ProductListViewWidget> createState() => _ProductListViewWidgetState();
}

class _ProductListViewWidgetState extends State<ProductListViewWidget> {

  final _shoppingBloc = ShoppingBloc();
  late Stream<ResponseOb> _shoppingStream;
  List<ShoppingData> allshoppingProductList = [];
  List shoppingProductList = [];

  bool isLoading = false;
  bool isFetching = false;
  final scroll_controller = ScrollController();

  int page = 1;
  int limit = 30;
  bool hasMore = true;
  Future fetch() async {
    _shoppingBloc.getShoppingProduct(brandId: 0, page: page);
    print(hasMore);
    if (isFetching) return;
    isFetching = true;
    if (hasMore == true) {
      print("truh as");
      _shoppingBloc.getShoppingProduct(brandId: 0, page: page);
      print("getting page - $page");
    }
  }

  Future refersh() async {
    setState(() {
      isFetching = false;
      hasMore = true;
      page = 1;
      shoppingProductList.clear();
    });

    fetch();
  }
  @override
  void initState() {
    super.initState();

    /// shopping stream
    _shoppingStream = _shoppingBloc.shoppingStream();
    _shoppingStream.listen((ResponseOb resp) {
      print("rese ${resp.loadPostState}");
      if (resp.success) {
        setState(() {
          print("resp.data.data.length ${resp.data.data.length}");
          for (var i = 0; i < resp.data.data.length; i++) {
            shoppingProductList.add([
              resp.data.data[i].id,//0
              resp.data.data[i].name.toString(),//1
              resp.data.data[i].stock,//2
              resp.data.data[i].price.toString(),//3
              resp.data.data[i].discount,//4
              resp.data.data[i].discountPrice.toString(),//5
              resp.data.data[i].photo.toString(),//6
              resp.data.data[i].categoryId,//7
              resp.data.data[i].categoryName.toString(),//8
              resp.data.data[i].brandName.toString(),//9
              resp.data.data[i].brandId,//10
              resp.data.data[i].isFavourite,//11
              resp.data.data[i].description.toString(),//12
              resp.data.data[i].detail.toString(),//13
              resp.data.data[i].count,//14
            ]);
          }
          isLoading = false;
          page++;

          isFetching = false;
          if (resp.data.data.length < 30) {
            hasMore = false;
          }
        });
      } else {
        isLoading = false;}
    });

    fetch();

    //Scroll controller
    scroll_controller.addListener(() {
      if (scroll_controller.position.maxScrollExtent ==
          scroll_controller.offset) {
        fetch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NathanTextView(
                text: widget.mainTitle,
                color: colorBlack,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
              GestureDetector(
                onTap: () {
                  // VisualFeedback.openFullScreenDialog(
                  //   context,
                  //   barrierColor: primaryColor,
                  //   widget: const SeeAllProducts(
                  //     title: 'latest-products',
                  //   ),
                  // );
                },
                child: NathanTextView(
                  text: "All",
                  color: colorPrimary.withOpacity(0.8),
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: EdgeInsets.only(left: 4.w, right: 4.w),
            child: Row(
              children: List.generate(
                shoppingProductList.length,
                    (index) {
                  final productList = shoppingProductList[index];
                  return ProductCardComponent(
                    id: productList[0] ?? 0,
                    stock: productList[2],
                    photo: productList[6] ??
                        "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
                    name: productList[1] ?? "-",
                    brandName: productList[9] ?? "",
                  );
                },

              ),
            ),
          ),
        ),
      ],
    );
  }
}
