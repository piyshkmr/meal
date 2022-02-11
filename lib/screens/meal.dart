import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/components/action_button.dart';
import 'package:meal/constants/colors.dart';
import 'package:meal/constants/styles.dart';
import 'package:meal/services/meal.api.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class Meal extends StatefulWidget {
  const Meal({Key? key, required this.categoryName}) : super(key: key);

  final String categoryName;

  @override
  _MealState createState() => _MealState();
}

class _MealState extends State<Meal> {
  List<dynamic> mealList = [];
  List<Widget> ingredients = [];
  Map meal = {};
  String mealId = "";

  void getMealList() async {
    MealAPI mealAPI = MealAPI();
    mealList = await mealAPI.getMealsList(widget.categoryName);
    setState(() {});
  }

  Future<String> getMealYoutube() async {
    MealAPI mealAPI = MealAPI();
    String mealYoutube = await mealAPI.getMealYoutube(mealId);

    return mealYoutube;
  }

  Future<String> getMealIngredients() async {
    MealAPI mealAPI = MealAPI();
    final mealIngredients = await mealAPI.getMealIngredients(mealId);
    return mealIngredients;
  }

  Future<String> getMealInstructions() async {
    MealAPI mealAPI = MealAPI();
    String mealInstructions = await mealAPI.getMealInstructions(mealId);
    return mealInstructions;
  }

  @override
  void initState() {
    super.initState();
    getMealList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: mealList.isNotEmpty
            ? PageView.builder(
                onPageChanged: (currentPageIndex) {
                  mealId = mealList[currentPageIndex]["idMeal"];
                },
                scrollDirection: Axis.vertical,
                itemCount: mealList.length,
                itemBuilder: (context, index) {
                  return Container(
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ActionButton(
                                          name: "Ingredients",
                                          icon: Icons.shopping_basket,
                                          onPress: () async {
                                            final data =
                                                await getMealIngredients();

                                            showBottomSheet(context, data);
                                          }),
                                      const SizedBox(
                                        height: 34.0,
                                      ),
                                      ActionButton(
                                          name: "Instructions",
                                          icon: Icons.dining,
                                          onPress: () async {
                                            final data =
                                                await getMealInstructions();

                                            showBottomSheet(context, data);
                                          }),
                                      const SizedBox(
                                        height: 34.0,
                                      ),
                                      ActionButton(
                                          name: "Youtube",
                                          icon: Icons.play_circle_fill,
                                          onPress: () async {
                                            final url = await getMealYoutube();
                                            await launch(url);
                                          }),
                                    ],
                                  ),
                                )),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14.0, vertical: 14.0),
                                    child: Text(
                                        "❤ " + mealList[index]["strMeal"],
                                        textAlign: TextAlign.left,
                                        style: kHeading),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(mealList[index]["strMealThumb"]),
                        ),
                      ));
                })
            : const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
      ),
    );
  }

  Future<dynamic> showBottomSheet(BuildContext context, String data) {
    return showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 34.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: kBgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 14.0),
                width: double.infinity,
                child: Text(
                  data,
                  style: kTitle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
