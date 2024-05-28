import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../bloc/shopping/category_bloc.dart';
import '../../../../helpers/response_ob.dart';
import '../../../../objects/shopping/category_view_ob.dart';
import '../../../../resources/colors.dart';
import '../../../../widgets/circle_loading_widget.dart';
import '../../../../widgets/nathan_text_view.dart';
import '../brands_screen.dart';

class TopCategory extends StatefulWidget {
  const TopCategory({Key? key}) : super(key: key);

  @override
  State<TopCategory> createState() => _TopCategoryState();
}

class _TopCategoryState extends State<TopCategory> {

  final _categoryBloc = CategoryBloc();
  late Stream<ResponseOb> _categoryStream;
  List<CategoryViewData> categoryViewList = [];

  @override
  void initState() {
    super.initState();
    _categoryStream = _categoryBloc.categoryStream();
    _categoryStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          categoryViewList = (resp.data as CategoryViewOb).data ?? [];
        });
      } else {}
    });

    _categoryBloc.getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return categoryViewList.isEmpty ?
    Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: const Center(child: CircleLoadingWidget()),
    ) : Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.2.h),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        crossAxisSpacing: 3.0,
        mainAxisSpacing: 3.0,
      // childAspectRatio:
       childAspectRatio: MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height / 1.45), //2/ 3, //(2 / 2),
        shrinkWrap: true,
        children: List.generate(
          categoryViewList == null
              ? 10
              : categoryViewList.length < 12 ? categoryViewList.length : 12,
              (index) {
            return GestureDetector(
              onTap: ()=> Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => BrandsScreen(
                    categoryId: categoryViewList[index].id ?? 0,
                      categoryName: categoryViewList[index].name ?? "",
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 4.5.h, // Image
                    backgroundColor: colorSeconary,
                    child: CircleAvatar(
                      radius: 4.h, // Image radius
                      backgroundColor: colorSeconary,
                      backgroundImage: NetworkImage(categoryViewList[index].photo ?? ""),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Center(
                    child: NathanTextView(
                      text: categoryViewList[index].name ?? "",
                      color: colorBlack,
                      fontSize: 16.sp,
                      isCenter: true,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
