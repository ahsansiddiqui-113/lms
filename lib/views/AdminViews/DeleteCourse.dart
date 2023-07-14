import 'package:flutter/material.dart';
import 'package:lms/views/AdminViews/DeleteCourseFromCategory.dart';

import '../../model/category_model.dart';

class DeleteCourse extends StatelessWidget {
  const DeleteCourse({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Delete Course"),
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: CategoryList.categoryList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // setCourses(CategoryList.categoryList[index].categoryName);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeleteCourseFromCategory(
                        categoryName:
                            CategoryList.categoryList[index].categoryName,
                      ),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child:
                          Text(CategoryList.categoryList[index].categoryName),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
