import 'package:flutter/material.dart';
import 'package:meal/constants/styles.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.onPress,
    required this.name,
    required this.image,
  }) : super(key: key);

  final void Function() onPress;
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        margin: const EdgeInsets.only(bottom: 14.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(image),
            ),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.3),
            child: Center(
                child: Text(
              name,
              style: kHeading.copyWith(color: Colors.white),
            )),
          ),
        ),
      ),
    );
  }
}

//  Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Image.network(
//                 "https://www.themealdb.com/images/category/chicken.png"),
//             const Text(
//               "Chicken",
//               style: TextStyle(
//                 color: kPrimaryText,
//                 fontSize: 18.0,
//               ),
//             )
//           ],
//         ),