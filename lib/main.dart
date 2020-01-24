import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var now = new DateTime.now();
  var msg = ''; 
  int day = 0, month = 0, year = 0;
  var userDay = TextEditingController();
  var userMonth = TextEditingController();
  var userYear = TextEditingController();
  var secondDay = TextEditingController();
  var secondMonth = TextEditingController();
  var secondYear = TextEditingController();
  List<int> months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]; 

  Widget createInput(control, hint, limit) {
    return Expanded( 
      child: TextField(
        controller: control,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: hint,  
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
        ),
        
        textAlign: TextAlign.center,
        maxLength: limit,
        keyboardType: TextInputType.number,
      ),
    );
  }

  onClick() {
    int userM = int.parse(userMonth.text);
    int userD = int.parse(userDay.text);
    int userY = int.parse(userYear.text);
    int currentDay, currentMonth, currentYear;
    if (secondDay.text.isNotEmpty && secondMonth.text.isNotEmpty && secondYear.text.isNotEmpty) {
      currentDay = int.parse(secondDay.text);
      currentMonth = int.parse(secondMonth.text);
      currentYear = int.parse(secondYear.text);
    } else {
      currentDay = now.day;
      currentMonth = now.month;
      currentYear = now.year;
    }

    // if (userY > now.year || (userY == now.year && userM > now.month && userD > now.day)) {
    //   msg = 'Invalid date';
    // }
    if (userM > 12 || userM <= 0) {
      msg = 'Invalid date';
    }
    else if ([1, 3, 5, 7, 8, 10, 12].contains(userM) && (userD > 31 || userD <= 0)) {
      msg = 'Invalid date';
    }
    else if ([4, 6, 9, 11].contains(userM) && (userD > 30 || userD <= 0)) {
      msg = 'Invalid date';
    }
    else if (userM == 2 && (userD > 28 || userD <= 0)) {
      msg = 'Invalid date';
    }
    else if (currentMonth > 12 || currentMonth <= 0) {
      msg = 'Invalid date';
    }
    else if ([1, 3, 5, 7, 8, 10, 12].contains(currentMonth) && (currentDay > 31 || currentDay <= 0)) {
      msg = 'Invalid date';
    }
    else if ([4, 6, 9, 11].contains(currentMonth) && (currentDay > 30 || currentDay <= 0)) {
      msg = 'Invalid date';
    }
    else if (userM == 2 && (currentDay > 28 || currentDay <= 0)) {
      msg = 'Invalid date';
    }
    else {
      if (userD > currentDay) { 
        currentDay = currentDay + months[userD - 1]; 
        currentMonth = currentMonth - 1; 
      } 

      if (userM > currentMonth) { 
        currentYear = currentYear - 1; 
        currentMonth = currentMonth + 12; 
      }
      day = currentDay - userD; 
      month = currentMonth - userM; 
      year = currentYear - userY; 
      msg = 'You are $day days, $month months and $year years old.';   
    }

    
    
    setState(() { 
      msg = msg;     
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Calculator',
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Age Calculator'),
        ),
        body: Container( 
          margin: EdgeInsetsDirectional.fromSTEB(50, 30, 50, 10),
          child:Column(
            children: <Widget>[
              // Padding(padding: EdgeInsets.all()),
              Text(
                'Date of Birth',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25
                ),
              ),
              Row(
                children: <Widget>[
                  createInput(userDay, 'Day', 2),
                  createInput(userMonth, 'Month', 2),
                  createInput(userYear, 'Year', 4)
                ],
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                'Second Date',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25
                ),
              ),
              Row(
                children: <Widget>[
                  createInput(secondDay, 'Day', 2),
                  createInput(secondMonth, 'Month', 2),
                  createInput(secondYear, 'Year', 4)
                ],
              ),              
              // TextField(
              //   controller: userDay,
              //   decoration: InputDecoration(
              //     fillColor: Colors.white,
              //     filled: true,
              //     hintText: 'Day',  
              //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              //   ),
                
              //   textAlign: TextAlign.center,
              //   maxLength: 2,
              //   keyboardType: TextInputType.number,
              // ),
              // TextField(
              //   controller: userMonth,
              //   decoration: InputDecoration(
              //     fillColor: Colors.white,
              //     filled: true,
              //     hintText: 'Month',  
              //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              //   ),
                
              //   textAlign: TextAlign.center,
              //   maxLength: 2,
              //   keyboardType: TextInputType.number,
              // ),
              // TextField(
              //   controller: userYear,
              //   decoration: InputDecoration(
              //     fillColor: Colors.white,
              //     filled: true,
              //     hintText: 'Year',  
              //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              //   ),
                
              //   textAlign: TextAlign.center,
              //   maxLength: 4,
              //   keyboardType: TextInputType.number,
              // ),
              MaterialButton(
                padding: EdgeInsets.all(20),
                onPressed: onClick,
                color: Colors.indigo,
                child: Text(
                  'Calculate',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(20)),
              Text(
                msg,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30
                ),
              )  
            ],
          )
        )
      ),
    );
  }
}