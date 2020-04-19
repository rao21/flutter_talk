import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//#080608
//#fefdfd
class Details extends StatefulWidget {
  Details({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Details createState() => _Details();
}

class _Details extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OrientationBuilder(builder: (context, orientation) {
      return DetailUi(
              orientation: orientation,
            );
    }));
  }
}

Widget _customAddBtn() {
  return SizedBox(
    height: 30,
    width: 40,
    child: OutlineButton(
        borderSide: BorderSide(width: 1.0, color: Colors.white),
        child: Text(
          "+",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        onPressed: () {}),
  );
}


class DetailUi extends StatelessWidget {
  final Widget widget;
  final Orientation orientation;
  DetailUi({
    Key key,
    this.widget,
    this.orientation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFF15322D)),
      child: Stack(
        children: <Widget>[ 
          Align(
            alignment: orientation == Orientation.portrait 
            ?Alignment.topCenter  
            :Alignment.topLeft,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white10,
                  image: DecorationImage(
                      image: NetworkImage(
                        'https://images.pexels.com/photos/2001154/pexels-photo-2001154.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                      ),
                      fit: BoxFit.cover)),
                      width: orientation == Orientation.portrait 
                              ? MediaQuery.of(context).size.width  
                              : MediaQuery.of(context).size.width / 2,
                      height: orientation == Orientation.portrait 
                              ? MediaQuery.of(context).size.height /1.6
                              : MediaQuery.of(context).size.height,
                             
            ),
          ),
          Align(
            alignment: orientation == Orientation.portrait 
            ? Alignment.bottomCenter
            :Alignment.topRight,
            child: Container(
              width: orientation == Orientation.portrait 
                     ? MediaQuery.of(context).size.width
                     : MediaQuery.of(context).size.width / 1.8,
              height: orientation == Orientation.portrait 
                              ? MediaQuery.of(context).size.height/1.8
                              : MediaQuery.of(context).size.height,
              decoration: orientation == Orientation.portrait
                  ? BoxDecoration(
                      color: Color(0xFF15322D),
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(40.0),
                          topRight: const Radius.circular(40.0)))
                  : BoxDecoration(
                      color: Color(0xFF15322D),
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(40.0),
                          bottomLeft: const Radius.circular(40.0))),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "---Plant",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Monstera",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "759",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(height: 40.0),
                    Text(
                      "The monster offer awesome tropical fortage and is a great statement plant,The monster offer awesome tropical fortage and is a great statement plant",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: <Widget>[
                        _customAddBtn(),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Text(
                            "1",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        _customAddBtn(),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          width: 60,
                          child: RaisedButton(
                            color: Color(0xFF15322D),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                                side: BorderSide(color: Colors.white)),
                            onPressed: () {},
                            child: Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.white)),
                                onPressed: () {},
                                child: Text('Add To Cart')),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
