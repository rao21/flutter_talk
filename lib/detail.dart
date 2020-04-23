import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plants/PlantsModel.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key, @required this.plant}) : super(key: key);

  final PlantsModel plant;

  @override
  _Details createState() => _Details();
}

class _Details extends State<DetailScreen> {
  final _themeColor = Color(0xFF15322D);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textColor = Colors.white;

    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        return Container(
          child: Stack(
            children: <Widget>[
              buildImage(screenSize, orientation),
              buildDetailWidget(screenSize, textColor, orientation),
            ],
          ),
        );
      }),
    );
  }

  Align buildImage(Size screenSize, Orientation orientation) {
    return Align(
      alignment: orientation == Orientation.portrait
          ? Alignment.topCenter
          : Alignment.topLeft,
      child: Container(
         width: orientation == Orientation.portrait //orientation == Orientation.portrait
            ? screenSize.width
            : screenSize.width / 1.8,
        height: orientation == Orientation.portrait // orientation == Orientation.portrait
            ? screenSize.height / 2
            : screenSize.height,
        decoration:orientation == Orientation.portrait
        ? BoxDecoration(
          color: Colors.white10,
          image: DecorationImage(
            image: ExactAssetImage(widget.plant.image),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter
          ),
        ):BoxDecoration(
          color: Colors.orange,
          image: DecorationImage(
            image: ExactAssetImage(widget.plant.image),
            fit: BoxFit.fill,
            alignment: Alignment.topCenter
          ),
      ))
    );
  }





  Align buildDetailWidget(
      Size screenSize, Color textColor, Orientation orientation) {
    return Align(
      alignment: orientation == Orientation.portrait//orientation == Orientation.portrait
          ? Alignment.bottomCenter
          : Alignment.bottomRight,
      child: Container(
        width: orientation == Orientation.portrait //orientation == Orientation.portrait
            ? screenSize.width
            : screenSize.width  / 1.8,
        height: orientation == Orientation.portrait// orientation == Orientation.portrait
            ? screenSize.height / 2
            : screenSize.height ,
        decoration: orientation == Orientation.portrait //orientation == Orientation.portrait
            ? BoxDecoration(
                color: _themeColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0),
                ),
              )
            : BoxDecoration(
                color: _themeColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  bottomLeft: const Radius.circular(40.0),
                ),
              ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "--- Plant",
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: textColor),
              ),
             // SizedBox(height: 20.0),
              Text(
                widget.plant.name,
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(color: textColor),
              ),
             // SizedBox(height: 8.0),
              Text(
                '\$ ${widget.plant.price}',
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: textColor),
              ),
             // SizedBox(height: 36.0),
              Text(
                widget.plant.description,
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .copyWith(color: textColor),
              ),
             // SizedBox(height: 24.0),
              Row(
                children: <Widget>[
                  _calculationButton(false),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "1",
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(color: textColor),
                    ),
                  ),
                  _calculationButton(true),
                ],
              ),
             // SizedBox(height: 24.0),
              Row(
                children: <Widget>[
                  RaisedButton(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    color: _themeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: textColor),
                    ),
                    onPressed: () {},
                    child: Icon(
                      Icons.favorite,
                      color: textColor,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: RaisedButton(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      color: textColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: textColor),
                      ),
                      onPressed: () {print(orientation);},
                      child: Text('Add To Cart'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _calculationButton(bool isAddition) {
  return SizedBox(
    height: 30,
    width: 40,
    child: OutlineButton(
        borderSide: BorderSide(width: 1.0, color: Colors.white),
        child: Text(
          isAddition ? "+" : "-",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {}),
  );
}
