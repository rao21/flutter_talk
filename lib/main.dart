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
      title: 'Flutter Karachi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PlantList plantData;
  bool _isLoading = false;
  final _themeColor = Color(0xFF15322D);
  final _accentColor = Color(0xFF879C95);
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: !_isLoading
            ? Container(
                color: _themeColor,
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
                  valueColor: AlwaysStoppedAnimation<Color>(_themeColor),
                ),
              ),
      ),
    );
  }

  Widget buildCardGrid() {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(8.0),
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
                Expanded(child: buildCardImage(index)),
                !index.isEven
                    ? SizedBox()
                    : buildCardDescription(index, context),
              ],
            ),
            buildAddButton(),
          ],
        ),
      ),
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, index.isEven ? 3 : 2),
    );
  }

  ClipRRect buildAddButton() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(12.0),
        bottomLeft: Radius.circular(12.0),
      ),
      child: Container(
        padding: EdgeInsets.all(4.0),
        child: Icon(Icons.add),
        color: Color(0xFFC1CEC7),
      ),
    );
  }

  Column buildCardDescription(int index, BuildContext context) {
    return Column(
      children: <Widget>[
        buildPlantName(index, context),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            buildPriceText(index, context),
            buildViewDetailButton(context, index)
          ],
        )
      ],
    );
  }

  Padding buildPlantName(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
      child: Text(
        plantData.data[index].name,
        style: Theme.of(context)
            .textTheme
            .subtitle
            .copyWith(color: Color(0xFF46554E)),
      ),
    );
  }

  FlatButton buildViewDetailButton(BuildContext context, int index) {
    return FlatButton(
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
            builder: (context) => DetailScreen(
              plant: plantData.data[index],
            ),
          ),
        );
      },
    );
  }

  Padding buildPriceText(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        '\$ ${plantData.data[index].price}',
        style: Theme.of(context)
            .textTheme
            .caption
            .copyWith(color: Color(0xFF5D6562)),
      ),
    );
  }

  ClipRRect buildCardImage(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      child: Image(
        fit: BoxFit.cover,
        image: AssetImage(plantData.data[index].image),
      ),
    );
  }

  TextFormField buildSearchField() {
    return TextFormField(
      controller: searchController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
          color: _accentColor,
        ),
        hintText: 'Search here',
        hintStyle: TextStyle(
          color: _accentColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _accentColor),
          borderRadius: BorderRadius.all(const Radius.circular(32.0)),
        ),
      ),
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
              style: TextStyle(color: _accentColor),
            ),
            onPressed: () {
              print(index);
            },
          );
        });
  }

  void _loadData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      plantData = await readData();
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<PlantList> readData() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    final jsonResponse = json.decode(jsonString);
    return PlantList.fromJson(jsonResponse);
  }
}
