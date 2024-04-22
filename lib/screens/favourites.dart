import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/screens/home_screen.dart';
import 'package:fluttertest/services/dbHelper.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<Map<String, dynamic>> items = [];

  bool _isloading = true;

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
    _refreshItems();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Icon(Icons.arrow_back)),
        backgroundColor: Colors.orange,
        title: const Text("Favourites"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: items.length,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: items.isEmpty
                          ? const Center(
                              child: Text(
                              "Favourites List is Empty",
                              style: TextStyle(fontSize: 25),
                            ))
                          : ListTile(
                              title: Text(items[index]['title']),
                              subtitle:
                                  Text(items[index]['servings'].toString()),
                              trailing: InkWell(
                                onTap: () async {
                                  await DBHelper.deleteItem(items[index]['id']);
                                  _refreshItems();
                                  print(items.length);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 15,
                                ),
                              ),
                            ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
