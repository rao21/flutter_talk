import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'PlantsModel.dart';
import 'detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

Future<PlantList> readData() async {
  String jsonString = await rootBundle.loadString('assets/data.json');
  ;
  final jsonResponse = json.decode(jsonString);
  PlantList plants = new PlantList.fromJson(jsonResponse);
  return plants;
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PlantList plantData;
  bool _isloading = false;
  Color _color = Color(0xFF15322D);
  final searchController = TextEditingController();
  void _loadData() async {
    _isloading = true;
    try {
      plantData = await readData();
    } catch (e) {} finally {
      _isloading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: !_isloading
            ? Container(
                color: _color,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: buildSearchField(),
                    ),
                    SizedBox(
                      height: 30.0,
                      child: buildHeaderList(),
                    ),
                    Expanded(child: buildCardGrid())
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                backgroundColor: _color,
              )),
      ),
    );
  }

  Widget buildCardGrid() {
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(8.0),
      crossAxisCount: 4,
      itemCount: plantData.data.length,
      itemBuilder: (BuildContext context, int index) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(plantData.data[index].image),
                    ),
                  ),
                ),
                !index.isEven
                    ? SizedBox()
                    : Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                            child: Text(
                              plantData.data[index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle
                                  .copyWith(color: Color(0xFF46554E)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  '\$ ${plantData.data[index].price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(color: Color(0xFF5D6562)),
                                ),
                              ),
                              FlatButton(
                                child: Text(
                                  'View details',
                                  style: TextStyle(
                                    color: Color(0xFF19806D),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Details()),
                                  );
                                },
                              )
                            ],
                          )
                        ],
                      ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
              ),
              child: Container(
                padding: EdgeInsets.all(4.0),
                child: Icon(Icons.add),
                color: Color(0xFFC1CEC7),
              ),
            ),
          ],
        ),
      ),
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, index.isEven ? 3 : 2),
    );
  }

  ListView buildHeaderList() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: plantData.data.length,
        itemBuilder: (context, index) {
          return FlatButton(
            child: Text(
              plantData.data[index].name,
              style: TextStyle(
                color: Color(0xFF879C95),
              ),
            ),
            onPressed: () {
              print(index);
            },
          );
        });
  }

  TextFormField buildSearchField() {
    return TextFormField(
      controller: searchController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
          color: Color(0xFF879C95),
        ),
        hintText: 'Search here',
        hintStyle: TextStyle(
          color: Color(0xFF879C95),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF879C95),
          ),
          borderRadius: BorderRadius.all(
            const Radius.circular(32.0),
          ),
        ),
      ),
    );
  }
}
