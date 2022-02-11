import 'package:flutter/material.dart';
import 'package:meal/components/category_card.dart';
import 'package:meal/constants/colors.dart';
import 'package:meal/screens/meal.dart';
import 'package:meal/services/meal.api.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> categories = [];

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  void getCategories() async {
    MealAPI mealAPI = MealAPI();
    categories = await mealAPI.getMealCategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.fastfood,
              color: kPrimaryColor,
            ),
            Text(
              "Meal",
              style: TextStyle(color: kPrimaryColor),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: categories.isNotEmpty
            ? GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 14.0),
                itemBuilder: (context, index) {
                  return CategoryCard(
                    image: categories[index]["strCategoryThumb"],
                    name: categories[index]["strCategory"],
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Meal(
                            categoryName: categories[index]["strCategory"],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
      ),
    );
  }
}
