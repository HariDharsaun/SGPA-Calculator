import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<String> grades = ["O", "A+", "A", "B+", "B", "C"];
List<int> credits = [4, 3, 2, 1];
List<double> historypoints = [];
List<String> historysub = [];

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  Map<String, int> map = {"O": 10, "A+": 9, "A": 8, "B+": 7, "B": 6, "C": 5};
  List<Map<String, int>> subjects = [];
  int creditVal = 0;
  int gradeVal = 0;
  int total_points = 0;
  int total_credits = 10;
  double sgpa = 0;
  String name = "";
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    // Dynamic padding and font size
    double buttonFontSize = height * 0.025;
    
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          leading: Image.asset("assets/College Logo.png",),
          backgroundColor: Colors.blue,
          centerTitle: true,
          titleSpacing: 2,
          title: Text("SGPA CALCULATOR", style: TextStyle(color: Colors.white, fontSize: buttonFontSize)),
        ),
        endDrawer: Drawer(
          backgroundColor: Colors.blue,
          child: SafeArea(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.history, size: 60, color: Colors.white60),
                      SizedBox(height: 6),
                      Text(
                        "History",
                        style: TextStyle(color: Colors.white60, fontSize: 30),
                      ),
                    ],
                  ),
                ),
                ...List.generate(historypoints.length, (index) {
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: ListTile(
                      tileColor: Colors.blue[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            subjects.removeAt(index);
                            historysub.removeAt(index);
                            historypoints.removeAt(index);
                            reCalculateSgpa();
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 191, 28, 16),
                        ),
                      ),
                      title: Row(
                        children: [
                          Text("${index + 1}) "),
                          SizedBox(width: 2,),
                          Expanded(
                            child: Text(
                              historysub[index],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.star_rate_outlined,color: const Color.fromARGB(255, 2, 169, 152)),
                          SizedBox(width: 4),
                          Text(historypoints[index].toStringAsFixed(2),
                          style: TextStyle(color: Colors.black38,fontSize: 13,fontWeight: FontWeight.bold),
                          ),
                        ]
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),

        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Enter Subject Name :",
                  style: TextStyle(fontSize: buttonFontSize, color: Colors.white70),
                ),
              ),
              SizedBox(height: 6),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: TextField(
                  controller: _controller,
                  cursorColor: Colors.blue,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white24,
                    hintText: "eg : Discrete Mathematics",
                    hintStyle: TextStyle(color: Colors.white38),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blue),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Subject Grade :",
                  style: TextStyle(fontSize: buttonFontSize, color: Colors.white70),
                ),
              ),
              SizedBox(height: 1),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    gradeButton("O", height, width),
                    gradeButton("A+", height, width),
                    gradeButton("A", height, width),
                    gradeButton("B+", height, width),
                    gradeButton("B", height, width),
                    gradeButton("C", height, width),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Subject Credit :",
                  style: TextStyle(fontSize: buttonFontSize, color: Colors.white70),
                ),
              ),
              SizedBox(height: 1),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    creditButton("4", height, width),
                    creditButton("3", height, width),
                    creditButton("2", height, width),
                    creditButton("1", height, width),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.center,
                child: button("Calculate", height, width, buttonFontSize),
              ),
              SizedBox(height: height * 0.06),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SGPA : ",
                    style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: buttonFontSize,
                    ),
                  ),
                  Text(
                    sgpa.toStringAsFixed(2),
                    style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: buttonFontSize,
                    ),
                  ),
                ],
              ),
              SizedBox(height: (height / 6) - 100),
              Align(
                alignment: Alignment.center,
                child: resetButton("Reset", height, width, buttonFontSize),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Grade Button Widget
  String selectedGrade = "";
  Widget gradeButton(String grade, double height, double width) {
    bool isSelectedgrade = selectedGrade == grade;
    return InkWell(
      onTap: () {
        setState(() {
          selectedGrade = grade;
          gradeVal = map[grade]!;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          height: height * 0.12,
          width: width * 0.12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelectedgrade ? Colors.deepOrangeAccent : Colors.blue,
          ),
          child: Text(
            grade,
            style: TextStyle(color: Colors.white, fontSize: width * 0.030),
          ),
        ),
      ),
    );
  }

  //Credit Button Widget
  String selectedCredit = "";
  Widget creditButton(String credit, double height, double width) {
    bool isSelectedcredit = selectedCredit == credit;
    return InkWell(
      onTap: () {
        setState(() {
          selectedCredit = credit;
          creditVal = int.parse(credit);
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          height: height * 0.12,
          width: width * 0.12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelectedcredit ? Colors.deepOrangeAccent : Colors.blue,
          ),
          child: Text(
            credit,
            style: TextStyle(color: Colors.white, fontSize: width * 0.030),
          ),
        ),
      ),
    );
  }

  //Calculate Button
  Widget button(String name, double height, double width, double fontSize) {
    return InkWell(
      onTap: () {
        setState(() {
          calculateSgpa();
        });
      },

      child: Container(
        alignment: Alignment.center,
        height: height * 0.05,
        width: width * 0.30,
        decoration: BoxDecoration(
          color: Colors.lightGreen,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        ),
      ),
    );
  }

  Widget resetButton(String name, double height, double width, double fontSize) {
    return InkWell(
      onTap: () {
        setState(() {
          subjects.clear();
          historypoints.clear();
          historysub.clear();
          sgpa = 0;
          selectedGrade = "";
          selectedCredit = "";
          gradeVal = 0;
          creditVal = 0;
          _controller.clear();
        });
      },

      child: Container(
        alignment: Alignment.center,
        height: height * 0.05,
        width: width * 0.25,
        decoration: BoxDecoration(
          color: Colors.red[500],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        ),
      ),
    );
  }

  void calculateSgpa() {
    if (_controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please Enter Subject Name."),
          backgroundColor: Colors.red[300],
          elevation: 5,
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
        ),
      );
    } else if (gradeVal == 0 || creditVal == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please select both grade and credit to calculate SGPA.",
          ),
          backgroundColor: Colors.red[300],
          elevation: 5,
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
        ),
      );
    } else {
      subjects.add({"grade": gradeVal, "credit": creditVal});

      // Calculate Sgpa
      int totalPoints = 0;
      int totalCredits = 0;
      for (var subject in subjects) {
        totalPoints += subject["grade"]! * subject["credit"]!;
        totalCredits += subject["credit"]!;
      }

      sgpa = totalPoints / totalCredits;
      historysub.add(_controller.text);
      historypoints.add(sgpa);

      // Reset
      selectedGrade = "";
      selectedCredit = "";
      gradeVal = 0;
      creditVal = 0;
      _controller.clear();
    }
  }

  reCalculateSgpa() {
    int totalPoints = 0;
    int totalCredits = 0;
    for (var subject in subjects) {
      totalPoints += subject["grade"]! * subject["credit"]!;
      totalCredits += subject["credit"]!;
    }
    sgpa = totalPoints / totalCredits;
  }
}
