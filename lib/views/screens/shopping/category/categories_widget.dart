import 'package:flutter/material.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/widgets/nathan_text_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../bloc/shopping/category_bloc.dart';
import '../../../../helpers/response_ob.dart';
import '../../../../objects/shopping/category_view_ob.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final _categoryBloc = CategoryBloc();
  late Stream<ResponseOb> _categoryStream;
  List<CategoryViewData> categoryViewList = [];

  @override
  void initState() {
    super.initState();
    _categoryStream = _categoryBloc.categoryStream();
    _categoryStream.listen((ResponseOb resp) {
      categoryViewList.add(CategoryViewData(id: 0, name: "Top Categories",
          photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6QF8VXMSxOoe3b3lf9GLaB0idx5u_9AWpKvnCM-odNxfFtDHczv2o7_-mOiLDaHb21qw&usqp=CAU"));
      if (resp.success) {
        setState(() {
          categoryViewList.addAll((resp.data as CategoryViewOb).data ?? []);
        });
      } else {}
    });

    _categoryBloc.getCategoryList();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NathanTextView(
              text: "All Categories",
              color: colorBlack,
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
            ),
            SizedBox(height: 1.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                categoryViewList.length,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.0.w),
                      child: RawChip(
                        backgroundColor: categoryViewList[index].id == 0 ? colorPrimary : colorPrimary.withOpacity(0.6), //Colors.grey.shade200,
                        labelPadding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 0.h),
                        label: Text(categoryViewList[index].name ?? "",
                          style: TextStyle(
                            color: colorWhite,
                            fontFamily: "Regular",
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        onPressed: () {
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        side: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                      ),
                    ),
              ),
            ),
          ],
        ));
  }
}
