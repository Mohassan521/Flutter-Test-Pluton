import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertest/Utils/utils.dart';
import 'package:fluttertest/components/drawer.dart';
import 'package:fluttertest/modals/RecipeModal.dart';
import 'package:fluttertest/screens/recipeInfo.dart';
import 'package:fluttertest/services/apiServices.dart';
import 'package:fluttertest/services/dbHelper.dart';
import 'package:get/get.dart';

class MyTextField extends GetxController {
  var query = "".obs;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> items = [];

  bool _isloading = true;

  final MyTextField controller = Get.put(MyTextField());

  void _refreshItems() async {
    final data = await DBHelper.getItems();
    setState(() {
      items = data;
      _isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshItems();
    print("num of items: ${items.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Flutter Test"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.only(left: 20.0, right: 20),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    controller.query.value = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  hintText: 'Search for Food recipes here...',
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder(
                future:
                    NetworkApiServices().getRecipeModal(controller.query.value),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Results> recipes = snapshot.data!;

                    List<int> favoriteIds =
                        items.map<int>((item) => item['id'] as int).toList();

                    return ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: recipes.length,
                        shrinkWrap: false,
                        itemBuilder: (context, index) {
                          bool isFavorite =
                              favoriteIds.contains(recipes[index].id);
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ListTile(
                                    onTap: () {},
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: EdgeInsets.all(16),
                                    tileColor: Colors.white10,
                                    title: Text(recipes[index].title ?? ""),
                                    subtitle: Text(
                                        "servings: ${recipes[index].servings.toString()} "),
                                    trailing: InkWell(
                                        onTap: () async {
                                          if (recipes[index].id != null) {
                                            DBHelper.createItem(
                                                recipes[index].id!,
                                                recipes[index].title ?? "",
                                                recipes[index].servings ?? 0);
                                            _refreshItems();
                                            print(
                                                "number of items ${items.length}");
                                            Utils().showToast(
                                                "Item with ID ${recipes[index].id} added to favourites",
                                                Colors.orange,
                                                Colors.white);
                                          }
                                        },
                                        child: Icon(
                                          Icons.favorite,
                                          color: isFavorite
                                              ? Colors.red
                                              : Colors.black,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    print("this is error: ${snapshot.error}");
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    print("something went wrong");
                  }
                  return Text("something went wrong outside");
                }),
          )
        ],
      ),
    );
  }
}
