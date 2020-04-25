import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plants/PlantsModel.dart';

final _themeColor = Color(0xFF15322D);
final _textColor = Colors.white;

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key, @required this.plant}) : super(key: key);

  final PlantsModel plant;

  @override
  _Details createState() => _Details();
}

class _Details extends State<DetailScreen> {
  bool isLargeScreen;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        bool isPortraitMode = orientation == Orientation.portrait;
        return Container(
          child: Stack(
            children: <Widget>[
              buildImage(screenSize, isPortraitMode),
              buildDetailWidget(screenSize, isPortraitMode),
            ],
          ),
        );
      }),
    );
  }

  Align buildImage(Size screenSize, bool isPortraitMode) {
    return Align(
      alignment: isPortraitMode ? Alignment.topCenter : Alignment.topLeft,
      child: Container(
        width: isPortraitMode ? screenSize.width : screenSize.width / 2,
        height: isPortraitMode ? screenSize.height / 1.8 : screenSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage(widget.plant.image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildDetailWidget(Size screenSize, bool isPortraitMode) {
    if (isPortraitMode)
      isLargeScreen = screenSize.width > 600 ? true : false;
    else
      isLargeScreen = isLargeScreen;

    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: _textColor, bodyColor: _textColor);
    const radius = Radius.circular(40.0);

    return Align(
      alignment:
          isPortraitMode ? Alignment.bottomCenter : Alignment.centerRight,
      child: Container(
        width: isPortraitMode ? screenSize.width : screenSize.width / 1.8,
        height: isPortraitMode ? screenSize.height / 2 : screenSize.height,
        decoration: BoxDecoration(
          color: _themeColor,
          borderRadius: isPortraitMode
              ? BorderRadius.only(
                  topLeft: radius,
                  topRight: radius,
                )
              : BorderRadius.only(
                  topLeft: radius,
                  bottomLeft: radius,
                ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "--- Plant",
                style: isLargeScreen ? textTheme.headline : textTheme.caption,
              ),
              Text(
                widget.plant.name,
                style: isLargeScreen ? textTheme.display2 : textTheme.title,
              ),
              Text(
                '\$ ${widget.plant.price}',
                style: isLargeScreen ? textTheme.display1 : textTheme.body2,
              ),
              Text(
                widget.plant.description,
                style: isLargeScreen ? textTheme.display1 : textTheme.body1,
              ),
              Row(
                children: <Widget>[
                  _raisedButton(
                    Text('-',
                        style: isLargeScreen
                            ? textTheme.display1
                            : textTheme.body2),
                    true,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: isLargeScreen ? 36.0 : 24.0),
                    child: Text(
                      '1',
                      style: isLargeScreen
                          ? textTheme.display1
                          : textTheme.subhead,
                    ),
                  ),
                  _raisedButton(
                    Text('+',
                        style: isLargeScreen
                            ? textTheme.display1
                            : textTheme.body2),
                    true,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  _raisedButton(
                    Icon(
                      Icons.favorite,
                      color: _textColor,
                    ),
                    true,
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: _raisedButton(
                        Text(
                          'Add To Cart',
                          style: isLargeScreen
                              ? textTheme.display1.copyWith(color: Colors.black)
                              : textTheme.body2.copyWith(color: Colors.black),
                        ),
                        false),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _raisedButton(Widget child, bool isThemeColor) {
    return RaisedButton(
      onPressed: () {},
      child: child,
      padding: EdgeInsets.symmetric(vertical: isLargeScreen ? 16.0 : 8.0),
      color: isThemeColor ? _themeColor : _textColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          width: isLargeScreen ? 2.0 : 1.0,
          color: _textColor,
        ),
      ),
    );
  }
}
