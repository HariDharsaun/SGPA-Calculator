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
  double sgpa = 0;
  String selectedGrade = "";
  String selectedCredit = "";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(width * 0.015),
          child: Image.asset("assets/College Logo.png"),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        titleSpacing: 2,
        title: Text(
          "SGPA CALCULATOR",
          style: TextStyle(color: Colors.white, fontSize: width * 0.045),
        ),
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
                    Icon(Icons.history, size: width * 0.15, color: Colors.white60),
                    SizedBox(height: height * 0.01),
                    Text(
                      "History",
                      style: TextStyle(color: Colors.white60, fontSize: width * 0.07),
                    ),
                  ],
                ),
              ),
              ...List.generate(historypoints.length, (index) {
                return Padding(
                  padding: EdgeInsets.all(width * 0.02),
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
                      icon: Icon(Icons.delete, color: Color.fromARGB(255, 191, 28, 16)),
                    ),
                    title: Row(
                      children: [
                        Text("${index + 1}) "),
                        SizedBox(width: width * 0.01),
                        Expanded(
                          child: Text(
                            historysub[index],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black54, fontSize: width * 0.04),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      historypoints[index].toStringAsFixed(2),
                      style: TextStyle(color: Colors.teal, fontSize: width * 0.04),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(width * 0.04),
        child: Column(
          children: [
            SizedBox(height: height * 0.01),
            buildText("Enter Subject Name :", width),
            SizedBox(height: height * 0.01),
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.03),
              child: TextField(
                controller: _controller,
                cursorColor: Colors.blue,
                style: TextStyle(color: Colors.white, fontSize: width * 0.04),
                decoration: InputDecoration(
                  hintText: "eg : Discrete Mathematics",
                  hintStyle: TextStyle(color: Colors.white38, fontSize: width * 0.035),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.blue),
                  ),
                ),
              ),
            ),
            buildText("Select Subject Grade :", width),
            SizedBox(height: height * 0.01),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: width * 0.02,
              children: grades.map((grade) => gradeButton(grade, height, width)).toList(),
            ),
            SizedBox(height: height * 0.02),
            buildText("Select Subject Credit :", width),
            SizedBox(height: height * 0.01),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: width * 0.02,
              children: credits.map((credit) => creditButton(credit.toString(), height, width)).toList(),
            ),
            SizedBox(height: height * 0.03),
            button("Calculate", height, width),
            SizedBox(height: height * 0.04),
            buildSGPAResult(width),
            SizedBox(height: height * 0.05),
            resetButton("Reset", height, width),
          ],
        ),
      ),
    );
  }

  Widget buildText(String text, double width) {
    return Text(
      text,
      style: TextStyle(fontSize: width * 0.05, color: Colors.white70),
      textAlign: TextAlign.center,
    );
  }

  Widget buildSGPAResult(double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "SGPA : ",
          style: TextStyle(color: Colors.deepOrangeAccent, fontSize: width * 0.07),
        ),
        Text(
          sgpa.toStringAsFixed(2),
          style: TextStyle(color: Colors.deepOrangeAccent, fontSize: width * 0.07),
        ),
      ],
    );
  }

  Widget gradeButton(String grade, double height, double width) {
    bool isSelected = selectedGrade == grade;
    return InkWell(
      onTap: () {
        setState(() {
          selectedGrade = grade;
          gradeVal = map[grade]!;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: height * 0.08,
        width: width * 0.16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.deepOrangeAccent : Colors.blue,
        ),
        child: Text(
          grade,
          style: TextStyle(color: Colors.white, fontSize: width * 0.045),
        ),
      ),
    );
  }

  Widget creditButton(String credit, double height, double width) {
    bool isSelected = selectedCredit == credit;
    return InkWell(
      onTap: () {
        setState(() {
          selectedCredit = credit;
          creditVal = int.parse(credit);
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: height * 0.08,
        width: width * 0.16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.deepOrangeAccent : Colors.blue,
        ),
        child: Text(
          credit,
          style: TextStyle(color: Colors.white, fontSize: width * 0.045),
        ),
      ),
    );
  }

  Widget button(String name, double height, double width) {
    return InkWell(
      onTap: () {
        setState(() {
          calculateSgpa();
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: height * 0.06,
        width: width * 0.4,
        decoration: BoxDecoration(
          color: Colors.lightGreen,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: width * 0.045),
        ),
      ),
    );
  }

  Widget resetButton(String name, double height, double width) {
    return InkWell(
      onTap: () {
        setState(() {
          subjects.clear();
          historypoints.clear();
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
        height: height * 0.06,
        width: width * 0.3,
        decoration: BoxDecoration(
          color: Colors.red[500],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: width * 0.045),
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
          content: Text("Please select both grade and credit to calculate SGPA."),
          backgroundColor: Colors.red[300],
          elevation: 5,
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
        ),
      );
    } else {
      subjects.add({"grade": gradeVal, "credit": creditVal});
      int totalPoints = 0;
      int totalCredits = 0;
      for (var subject in subjects) {
        totalPoints += subject["grade"]! * subject["credit"]!;
        totalCredits += subject["credit"]!;
      }
      sgpa = totalPoints / totalCredits;
      historysub.add(_controller.text);
      historypoints.add(sgpa);
      selectedGrade = "";
      selectedCredit = "";
      gradeVal = 0;
      creditVal = 0;
      _controller.clear();
    }
  }

  void reCalculateSgpa() {
    int totalPoints = 0;
    int totalCredits = 0;
    for (var subject in subjects) {
      totalPoints += subject["grade"]! * subject["credit"]!;
      totalCredits += subject["credit"]!;
    }
    sgpa = totalPoints / totalCredits;
  }
}
