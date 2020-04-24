import 'dart:convert';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'PlantsModel.dart';
import 'detail.dart';

void main() => runApp(DevicePreview(
      builder: (context) => MyApp(),
      enabled: !kReleaseMode,
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
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
  bool isLargeScreen;
  final _themeColor = Color(0xFF15322D);
  final _accentColor = Color(0xFF879C95);
  final searchController = TextEditingController();
 
  void _loadData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      plantData = await readDataFromFile();
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<PlantList> readDataFromFile() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    final jsonResponse = json.decode(jsonString);
    return PlantList.fromJson(jsonResponse);
  }
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        //body: Center(child: Text('Flutter for YOU!')),
        body: _isLoading ? _loader() : _mainContainer(),
      ),
    );
  }

  Center _loader() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(_themeColor),
      ),
    );
  }

  Container _mainContainer() {
    if (MediaQuery.of(context).orientation == Orientation.portrait)
      isLargeScreen = MediaQuery.of(context).size.width > 600 ? true : false;
    else
      isLargeScreen = isLargeScreen;

    return Container(
      color: _themeColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
            child: buildSearchField(),
            //child: Text('Child 1'),
          ),
          SizedBox(
            height: isLargeScreen ? 48.0 : 36.0,
            child: buildHeaderList(),
           // child: Text('Child 2'),
          ),
          Expanded(
            child: buildCardGrid(),
            //child: Text('Child 3'),
          )
        ],
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
        hintStyle: isLargeScreen
            ? Theme.of(context).textTheme.display1.copyWith(color: _accentColor)
            : Theme.of(context).textTheme.body1.copyWith(color: _accentColor),
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
              style: isLargeScreen
                  ? Theme.of(context).textTheme.display1.copyWith(
                      color: _accentColor, fontWeight: FontWeight.bold)
                  : Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(color: _accentColor),
            ),
            onPressed: () {
              print(index);
            },
          );
        });
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
ClipRRect buildCardImage(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      child: Image(
        fit: BoxFit.cover,
        image: AssetImage(plantData.data[index].image),
      ),
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
        SizedBox(height: isLargeScreen ? 24.0 : 0.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            buildPriceText(index, context),
            buildViewDetailButton(context, index)
          ],
        ),
        SizedBox(height: isLargeScreen ? 36.0 : 0.0)
      ],
    );
  }

  Padding buildPlantName(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
      child: Text(
        plantData.data[index].name,
        style: isLargeScreen
            ? Theme.of(context)
                .textTheme
                .display2
                .copyWith(color: Color(0xFF46554E), fontWeight: FontWeight.bold)
            : Theme.of(context)
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
        style: isLargeScreen
            ? Theme.of(context)
                .textTheme
                .display1
                .copyWith(color: Color(0xFF19806D), fontWeight: FontWeight.bold)
            : Theme.of(context)
                .textTheme
                .body2
                .copyWith(color: Color(0xFF19806D)),
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
        style: isLargeScreen
            ? Theme.of(context)
                .textTheme
                .display1
                .copyWith(color: Color(0xFF5D6562))
            : Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Color(0xFF5D6562)),
      ),
    );
  }

  

}
