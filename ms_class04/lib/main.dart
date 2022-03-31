import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           backgroundColor: Colors.black,
           shadowColor: Colors.cyan,
           elevation: 40,
           title: Center(child: Text("Shahab's Dicee",style: TextStyle(letterSpacing: 2,color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold,),),),
         ),

         body: DicePage(),
       ),
    );
  }
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> with SingleTickerProviderStateMixin {

// functions for bouncing btn 

  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.5, 
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }
@override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  //================================
  
    int leftDiceNo = 5;
    int rightDiceNo = 3;

  @override
  Widget build(BuildContext context) {

    _scale = 1 - _controller.value;

    void changebothDice(){
      setState(() {
               leftDiceNo= Random().nextInt(6) + 1;
               rightDiceNo = Random().nextInt(6) + 1;
                 });
    }
    
    
    return Column(
      children: [
        SizedBox(height: 100,),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              
// Left BTN          
              TextButton( onPressed: (){ 
                setState(() {
                              leftDiceNo = Random().nextInt(6) + 1;
                              print("Left Dice Number is $leftDiceNo");
                            });
              } ,child: Expanded(child: Image.asset("assets/dice$leftDiceNo.png", height: 200, width: 200,))),

              SizedBox(height: 20,),
// Rightt BTN          
              
              TextButton(onPressed:(){
                setState(() {
                              rightDiceNo = Random().nextInt(6)+1;
                              print("Right Dice Number is $rightDiceNo");
                            });
              }, child: Expanded(child: Image.asset("assets/dice$rightDiceNo.png", height: 200, width: 200,))),
            ],
            
          ),
        ),


// Animated Bouncing Button 
    SizedBox(height: 50,),
    Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Center(
              child: GestureDetector(
                
                onTap: (){changebothDice();},
                onTapDown: _tapDown,
                onTapUp: _tapUp,
                child: Transform.scale(
                  scale: _scale,
                  child: _animatedButton(),
                ),
              ),
            ),
          ],
),
          
      ],
    );
  }

  Widget  _animatedButton() {
    return Container(
      
      height: 40,
      width: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.cyan,
              blurRadius: 10.0,
              spreadRadius: 0,
              offset: Offset(0.0, 5.0),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.cyan,
              Colors.blue[900],
              Colors.cyan,
              
            ],
          )),
      child: Center(
        
         child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.sync, size: 20,color: Colors.white,),
              Text("Roll Them",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold,),),
            ],
          ),
         
      ),
    );
  }
void _tapDown(TapDownDetails details) {
    _controller.forward();
  }
void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }

  }


