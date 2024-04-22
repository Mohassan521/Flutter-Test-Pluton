import 'package:flutter/material.dart';
import 'package:fluttertest/modals/recipeInfoModal.dart';
import 'package:fluttertest/screens/home_screen.dart';
import 'package:fluttertest/services/apiServices.dart';

class RecipeInfo extends StatefulWidget {
  final String title;
  final int id;
  const RecipeInfo({super.key, required this.title, required this.id});

  @override
  State<RecipeInfo> createState() => _RecipeInfoState();
}

class _RecipeInfoState extends State<RecipeInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "${widget.title}",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              "Ingredients",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          FutureBuilder(
              future: NetworkApiServices().getRecipeInfo(widget.id),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        List<RecipeInfoModal> recipes = snapshot.data!;
                        return ListTile(
                          title: Text(recipes[index].title),
                        );
                      },
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const Text("Somethin went wrong");
              }))
        ],
      ),
    );
  }
}
