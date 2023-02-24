import 'package:flutter/material.dart';

class screen extends StatefulWidget {
  @override
  State<screen> createState() => _screenState();
}

class _screenState extends State<screen> {
  final TextEditingController htController = TextEditingController();
  final TextEditingController wtController = TextEditingController();
  final TextEditingController htControllerIn = TextEditingController();

  var kgWt, htWt, htWtIn;

  var result = "";
  // Initial Selected Value
  String wtdropdownvalue = 'Kg';

  // List of items in our dropdown menu
  var wtitems = [
    'Kg',
    'lb',
  ];

  // Initial Selected Value
  String htdropdownvalue = 'm';

  // List of items in our dropdown menu
  var htitems = [
    'm',
    'ft',
    'in',
    'cm',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Image.asset(
            'assets/images/bmiChart.jpg',
            scale: 2.5,
            width: MediaQuery.of(context).size.width,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),

                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      DropdownButton(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        dropdownColor: Colors.blue[50],
                        borderRadius: BorderRadius.circular(50),
                        // Initial Value
                        value: wtdropdownvalue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: wtitems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            wtdropdownvalue = newValue!;
                          });
                        },
                      ),
                      SizedBox(width: 20),
                      DropdownButton(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        borderRadius: BorderRadius.circular(50),
                        dropdownColor: Colors.blue[50],

                        // Initial Value
                        value: htdropdownvalue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: htitems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            htdropdownvalue = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ), //units is class in options.dart

                SizedBox(height: 20),
                TextField(
                  controller: wtController,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 211, 191, 245),
                    hintText: 'Weight ($wtdropdownvalue)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.monitor_weight_rounded),
                    suffixIcon: IconButton(
                        onPressed: () {
                          wtController.clear();
                        },
                        icon: Icon(Icons.clear)),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                TextField(
                  controller: htController,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 211, 191, 245),
                    hintText: 'Height ($htdropdownvalue)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.height),
                    suffixIcon: IconButton(
                        onPressed: () {
                          htController.clear();
                        },
                        icon: Icon(Icons.clear)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                if (htdropdownvalue == 'ft')
                  TextField(
                    controller: htControllerIn,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 211, 191, 245),
                      hintText: 'Height (in)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.height),
                      suffixIcon: IconButton(
                          onPressed: () {
                            htControllerIn.clear();
                          },
                          icon: Icon(Icons.clear)),
                    ),
                  ),

                SizedBox(
                  height: 20,
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 125, 75, 241)),
                    onPressed: () {
                      String wt = wtController.text.toString();
                      String ht = htController.text.toString();
                      String htIn = htControllerIn.text.toString();

                      if (wt != '' && ht != '') {
                        double iWt = double.parse(wt);
                        double iHt = double.parse(ht);

                        if (wtdropdownvalue == "lb") {
                          iWt = iWt / 2.204;
                        }

                        if (htdropdownvalue == "ft") {
                          if (htIn != '') {
                            double iHtIn = double.parse(htIn);
                            iHt = iHt / 3.28;
                            iHtIn = iHtIn / 39.37;
                            iHt = iHt + iHtIn;
                          } else {
                            double iHtIn;
                            iHt = iHt / 3.28;
                            iHtIn = 0;
                            iHt = iHt + iHtIn;
                          }
                        }

                        if (htdropdownvalue == "cm") {
                          iHt = iHt / 100;
                        }

                        double bmi = iWt / (iHt * iHt);

                        if (bmi < 18.5) {
                          setState(() {
                            result =
                                "Your BMI is ${bmi.toStringAsFixed(1)}\nUNDER WEIGHT";
                          });
                        } else if (bmi >= 18.5 && bmi <= 24.9) {
                          setState(() {
                            result =
                                "Your BMI is ${bmi.toStringAsFixed(1)}\nNORMAL WEIGHT";
                          });
                        } else if (bmi >= 25.0 && bmi <= 29.9) {
                          setState(() {
                            result =
                                "Your BMI is ${bmi.toStringAsFixed(1)}\nOVER WEIGHT";
                          });
                        } else if (bmi >= 30.0 && bmi <= 34.9) {
                          setState(() {
                            result =
                                "Your BMI is ${bmi.toStringAsFixed(1)}\nOBESE";
                          });
                        } else {
                          setState(() {
                            result =
                                "Your BMI is ${bmi.toStringAsFixed(1)}\nEXTREME OBESE";
                          });
                        }
                        ;
                      } else {
                        setState(() {
                          result = "Please Fill All Fields";
                        });
                      }
                    },
                    child: Text('CALCULATE')),

                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  child: Text(
                    ('$result'),
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      backgroundColor: Color.fromARGB(255, 255, 0, 0),
                      fontSize: 20,
                      color: Color.fromARGB(255, 2, 2, 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
