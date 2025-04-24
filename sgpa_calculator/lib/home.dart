import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
List<String> grades = ["O","A+","A","B+","B","C"];
List<int> credits = [4,3,2,1];
List<double> history = [];
class _HomePageState extends State<HomePage> {
  Map<String,int> map = {"O":10,"A+":9,"A":8,"B+":7,"B":6,"C":5};
  List<Map<String, int>> subjects = [];
  int creditVal = 0;
  int  gradeVal = 0;
  int total_points = 0;
  int  total_credits = 10;
  double sgpa = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent
      ),
      child: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          titleSpacing: 2,
          title: Text("SGPA CALCULATOR",style: TextStyle(color: Colors.white)),
          // leading : Container(
          //     child: Image.asset("assets/College Logo.png"),
          //   ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.blue[200],
          child: ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index){
              return ListTile(
                trailing: IconButton(
                  onPressed: (){
                    setState(() {
                      history.removeAt(index);
                    });
                  },
                  icon: Icon(Icons.delete),
                ),
                title: Text("Discrete Mathematicshfalksdhflkashdflkasjhdflkahsdflkjh",maxLines:2 ,overflow: TextOverflow.ellipsis,),
                subtitle:Text(history[index].toStringAsFixed(2)),
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: 1,
              ),
              Text("Enter Subject Name :",style: TextStyle(fontSize: 20,color: Colors.white70),),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: TextField(
                  cursorColor: Colors.blue,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "eg : Discrete Mathematics",
                    hintStyle: TextStyle(color: Colors.white38),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.blue
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.blue
                      )
                    ),
                  ),
                ),
              ),
              Text("Select Subject Grade :",style: TextStyle(fontSize: 20,color: Colors.white70),),
              SizedBox(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 gradeButton("O", height, width),
                 gradeButton("A+", height, width),
                 gradeButton("A", height, width),
                 gradeButton("B+", height, width),
                 gradeButton("B", height, width),
                 gradeButton("C", height, width),
                ],
              ),
              SizedBox(
                height: 1,
              ),
              Text("Select Subject Credit :",style: TextStyle(fontSize: 20,color: Colors.white70),),
              SizedBox(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  creditButton("4", height, width),
                  creditButton("3", height, width),
                  creditButton("2", height, width),
                  creditButton("1", height, width),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              button("Calculate", height, width),
              SizedBox(
                height: height*0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("SGPA : ",style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 28))
                  ,Text(sgpa.toStringAsFixed(2),style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 28),),
                ]
              ),
              SizedBox(
                height: (height/6)-100,
              ),
              resetButton("Reset", height, width)
            ],
          ),
        ),
      ),
    );
  }

  // Grade Button Widget
  String selectedGrade = "";
  Widget gradeButton(String grade,double height,double width)
  {
    bool isSelectedgrade = selectedGrade == grade;
    return InkWell(
      onTap: (){
        setState(() {
          selectedGrade = grade;
          gradeVal = map[grade]!;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          height: height*0.15,
          width:  width*0.12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelectedgrade?Colors.deepOrangeAccent:Colors.blue,
          ),
          child: Text(grade,style: TextStyle(color: Colors.white,fontSize: width*0.030),),
        ),
      ),
    );
  }

  //Credit Button Widget
  String selectedCredit = "";
  Widget creditButton(String credit,double height,double width)
  {
    bool isSelectedcredit = selectedCredit == credit;
    return InkWell(
      onTap: (){
        setState(() {
          selectedCredit = credit;
          creditVal = int.parse(credit);
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
            height: height*0.15,
            width:  width*0.12,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelectedcredit ? Colors.deepOrangeAccent : Colors.blue,
            ),
            child: Text(credit,style: TextStyle(color: Colors.white,fontSize: width*0.030),),
        ),
      ),
    );
  }


  //Calculate Button
  Widget button(String name,double height,double width)
  {
    return InkWell(
      onTap: () {
        setState(() {
          calculateSgpa();
        });
      },

      child: Container(
        alignment: Alignment.center,
        height: height*0.05,
        width: width*0.30,
        decoration: BoxDecoration(
          color: Colors.lightGreen,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: height*0.020
          ),
        ),
      ),
    );
  }

  Widget resetButton(String name,double height,double width)
  {
    return InkWell(
      onTap: () {
        setState(() {
          subjects.clear();
          history.clear();
          sgpa = 0;
          selectedGrade = "";
          selectedCredit = "";
          gradeVal = 0;
          creditVal = 0;
        });
      },

      child: Container(
        alignment: Alignment.center,
        height: height*0.05,
        width: width*0.25,
        decoration: BoxDecoration(
          color: Colors.red[500],
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: height*0.020
          ),
        ),
      ),
    );
  }

  void calculateSgpa()
  {
    if(gradeVal == 0 || creditVal == 0)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select both grade and credit to calculate SGPA."),
          backgroundColor: Colors.red[300],
          elevation: 5,
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
        )
      );
    }
    else{
      subjects.add({
              "grade": gradeVal,
              "credit": creditVal,
            });

            // Calculate SGPA
            int totalPoints = 0;
            int totalCredits = 0;
            for (var subject in subjects) {
              totalPoints += subject["grade"]! * subject["credit"]!;
              totalCredits += subject["credit"]!;
            }

            sgpa = totalPoints / totalCredits;
            history.add(sgpa);

            // Reset selections
            selectedGrade = "";
            selectedCredit = "";
            gradeVal = 0;
            creditVal = 0;
    }
  }
}




