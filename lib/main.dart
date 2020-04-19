import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final plantNames = [
    'Conifers',
    'Houseplant',
    'Perennial',
    'Ginkgo',
    'Cycads',
    'Monocots'
  ];

  var plantImages = [
    'assets/plant-1.jpg',
    'assets/plant-2.jpg',
    'assets/plant-3.jpg',
    'assets/plant-4.jpg',
    'assets/plant-5.jpg',
  ];

  var price = [
    '7.85',
    '4.00',
    '12.99',
    '9.99',
    '96.99',
  ];

  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color(0xFF15322D),
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
        ),
      ),
    );
  }

  Widget buildCardGrid() {
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(8.0),
      crossAxisCount: 4,
      itemCount: plantImages.length,
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
                      image: AssetImage(plantImages[index]),
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
                              plantNames[index],
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
                                  '\$ ${price[index]}',
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
        itemCount: plantNames.length,
        itemBuilder: (context, index) {
          return FlatButton(
            child: Text(
              plantNames[index],
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
