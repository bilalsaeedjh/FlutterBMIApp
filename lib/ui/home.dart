import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Bmi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BmiState();
  }
}

class BmiState extends State<Bmi> {
  final TextEditingController _ageController = new TextEditingController();
  final TextEditingController _heightController = new TextEditingController();
  final TextEditingController _weightController = new TextEditingController();
  double inches = 0.0;
  double result = 0.0;
  String _resultReading = "";

  String _finalResult = "";

  void _calculateBMI() {
    //Resourse 1: https://www.bcbst.com/providers/MPMTools/BMICalculator.shtm
    //Resource 2:  http://www.epic4health.com/bmiformula.html

//
//    BMI	Weight Status
//    Below 18.5	Underweight
//    18.5 – 24.9	Normal
//    25.0 – 29.9	Overweight
//    30.0 and Above	Obese

    setState(() {

      int age = int.parse(_ageController.text);
      double height = double.parse(_heightController.text);
      inches = height*12;
      double weight = double.parse(_weightController.text);

      if ((_ageController.text.isNotEmpty || age > 0)
          && ((_heightController.text.isNotEmpty || inches > 0)
              && (_weightController.text.isNotEmpty || weight > 0))) {
        result = weight / (inches * inches) * 703; // our BMI

        //Do the reading
        if (double.parse(result.toStringAsFixed(1)) < 18.5) {
          _resultReading = "Underweight";
          print(_resultReading);

        }else if (double.parse(result.toStringAsFixed(1)) >= 18.5
            && result < 25) {
          _resultReading = "Great Shape!"; // Normal
          print(_resultReading);
        }else if (double.parse(result.toStringAsFixed(1)) >= 25.0
            && result < 30) {
          _resultReading = "Overweight";
        }else if (double.parse(result.toStringAsFixed(1)) >= 30.0) {
          _resultReading = "Obese";
        }





      }else {
        result = 0.0;
      }

    });

    _finalResult = "Your BMI: ${result.toStringAsFixed(1)}";


  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('BMI (Body Mass Index)'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: new Container(
        alignment: Alignment.topCenter,
        child: Stack(
          children:<Widget>[
                Opacity(
                  opacity: 0.1,
                  child: Center(
                  child: new Image.asset(
                    'images/wall.jpg',
                    width: 1000.0,
                    height: 1200.0,
                    fit: BoxFit.fill,
                  ),
             ),
                ),
            ListView(
              padding: const EdgeInsets.all(2.0),
              children: <Widget>[
                new Image.asset(
                  'images/bmi.png',
                  height: 100.0,
                  width: 100.0,
                ),
                new Container(
                  margin: const EdgeInsets.all(3.0),
                  height: 260.0,
                  width: 290.0,
                  //color: Colors.grey.shade300,
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Opacity(

                          opacity: 0.3,
                          child: Image.asset('images/bmi.png',
                            height: 258.0,
                            width: 288.0,),
                        ),
                      ),
                      new Column(
                        children: <Widget>[
                          new TextField(
                            controller: _ageController,
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                                labelText: 'Age',
                                hintText: 'e.g: 34',
                                icon: new Icon(Icons.person_outline)),
                          ),

                          new TextField(
                              controller: _heightController,
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                  labelText: 'Height in feet',
                                  hintText: 'e.g 6.5',
                                  icon: new Icon(Icons.insert_chart))),
                          new TextField(
                              controller: _weightController,
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                  labelText: 'Weight in lbs',
                                  hintText: 'e.g 180',
                                  icon: new Icon(Icons.line_weight))),

                          new Padding(padding: new EdgeInsets.all(12)),

                          //calculate button
                          new Container(
                            alignment: Alignment.center,
                            child: new RaisedButton(
                              onPressed: _calculateBMI,
                              color: Colors.lightBlue,
                              child: new Text('Calculate BMI',style: TextStyle(fontSize: 18),),
                              textColor: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ],



                  ),
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("$_finalResult ",
                      style: new TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          fontSize: 19.9
                      ),),

                    new Padding(padding: const EdgeInsets.all(5.0)),

                    new Text("$_resultReading ",
                      style: new TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          fontSize: 19.9
                      ),),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: _textAnimationKit[1],
                    ),
                    Center(
                      child: _textAnimationKit[0],
                    ),

                    //Adding buttons to navigate towards youtube and gitHub
                    /* Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Column(
                        children: <Widget>[
                          IconButton(
                          icon: FaIcon(FontAwesomeIcons.github),
                          tooltip: 'Go to  our gitHub profile',
                          onPressed: () => launch('https://github.com/bilalsaeedjh'),
                        ),
                          Text(
                            "Github",
                            style: TextStyle(color:Colors.black54,fontWeight:FontWeight.bold,fontSize: 14) ,
                          )
                        ]
                      ),
                      SizedBox(width: 30,),
                      Column(
                        children: <Widget>[
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.youtube),
                            tooltip: 'Go to  our Youtube profile',
                            onPressed: () => launch('https://www.youtube.com/channel/UCZSgQGG74K2yuEDnbG4U1tQ?view_as=subscriber'),
                          ),
                          Text(
                            "Youtube",
                            style: TextStyle(color:Colors.black54,fontWeight:FontWeight.bold,fontSize: 14) ,
                          )
                        ]
                      ),

                    ],
                  )*/


                  ],


                ),
              ],

            ),
          ],
        ),

      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.github),
            title: Text('Github'),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.youtube),
            title: Text('Youtube'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),


    );
  }

  //Code for BottomNavigation Purpose
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      if(index==0){
        launch('https://github.com/bilalsaeedjh');
        _selectedIndex = index;
      }
      if(index==1){
        launch('https://www.youtube.com/channel/UCZSgQGG74K2yuEDnbG4U1tQ?view_as=subscriber');
        _selectedIndex = index;
      }

    });

  }
  //NavigationBar work ends here


  //Animation for the Text
  List<Widget> _textAnimationKit=[
    TyperAnimatedTextKit(
      onTap: () {
        print("Tap Event");
      },
      text: [
        "See our other Flutter Examples on:",
        "Github,",
        "Youtube",
        "- SkillzUPP Technologies",
      ],
      textStyle: TextStyle(fontSize: 20.0, fontFamily: "Bobbers",color:Colors.black),


      pause: Duration(seconds:  3),
      // speed: Duration(milliseconds:  1000),
    ),Align(
      alignment: Alignment.bottomRight,
      child: TextLiquidFill(
        text: 'SkillzUPP Technologies',
        waveColor: Colors.blue,
        waveDuration: Duration(milliseconds:700),
        loadDuration: Duration(seconds:20),
        boxBackgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        boxHeight: 30,
      ),
    ), SizedBox(
      width: 250.0,
      child: TypewriterAnimatedTextKit(
        onTap: () {
          print("Tap Event");
        },
        text: [
          "Discipline is the best tool",
          "Design first, then code",
          "Do not patch bugs out, rewrite them",
          "Do not test bugs out, design them out",
        ],
        textStyle: TextStyle(fontSize: 30.0, fontFamily: "Agne"),
      ),
    ),];
}
