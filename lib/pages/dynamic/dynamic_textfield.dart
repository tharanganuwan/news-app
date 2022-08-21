import 'package:cybehawks/components/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SingleListUse extends StatefulWidget {
  static final String tag = 'single-list-use';
  @override
  _SingleListUseState createState() => _SingleListUseState();
}

class Student1 {
  String _name;
  int _sessionId;

  Student1(this._name, this._sessionId);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get sessionId => _sessionId;

  set sessionId(int value) {
    _sessionId = value;
  }

  @override
  String toString() {
    return 'Student $_name from session $_sessionId';
  }
}

class _SingleListUseState extends State<SingleListUse> {
  List<Student1> _studentList = [Student1('', 1), Student1('', 2)];
  Map<int, Student1> _studentMap = {};

  List<TextEditingController> controllrs = [
    TextEditingController(),
    TextEditingController(),
  ];
  TextEditingController _dateController = TextEditingController();

  void _addNewStudent() {
    setState(() {
      print("max");

      _studentList.add(Student1('', 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.done,
      //     color: Colors.white,
      //   ),
      //   onPressed: () {
      //     if (_studentList.length != 0) {
      //       _studentList.forEach((student) => print(student.toString()));
      //     } else {
      //       print('map list empty');
      //     }
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      appBar: AppBar(
        title: Text('Create Poll'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your quection *',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              TextFormField(
                // controller: value.questionController,
                maxLength: 300,
                maxLines: 3,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Your Quection',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.50),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Quection';
                  }

                  return null;
                },
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: Builder(
                  builder: (context) {
                    print("List : ${_studentList.toString()}");
                    _studentMap = _studentList.asMap();
                    print("MAP : ${_studentMap.toString()}");
                    return ListView.builder(
                      itemCount: _studentMap.length,
                      itemBuilder: (context, position) {
                        print('Item Position $position');

                        return Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Option',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      // initialValue: _studentMap[position].name.length != 0
                                      //     ? _studentMap[position].name
                                      // : '',
                                      onFieldSubmitted: (name) {
                                        setState(() {
                                          _studentList[position].name = name;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Add option',
                                        hintStyle: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black26,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black12,
                                          ),
                                          // borderRadius: BorderRadius.all(
                                          //   Radius.circular(15.0),
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  (position == 0)
                                      ? SizedBox()
                                      : (position == 1)
                                          ? SizedBox()
                                          : (position + 1 ==
                                                  _studentList.length)
                                              ? IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      print("object");
                                                      print(position);
                                                      print("object");
                                                      _studentList
                                                          .removeAt(position);
                                                      controllrs
                                                          .remove(position);
                                                    });
                                                  },
                                                )
                                              : SizedBox(),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  _addNewStudent();
                },
                child: Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.amber
                      // border: Border(
                      //   left: BorderSide(
                      //     color: Colors.green,
                      //     width: 3,
                      //   ),
                      // ),
                      ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                      ),
                      GestureDetector(
                          onTap: () {
                            if (_studentList.length <= 5) {
                              print("object");
                              print("object");
                              print("Length student" +
                                  _studentList.length.toString());
                              _addNewStudent();
                              controllrs.add(TextEditingController());
                            }
                          },
                          child: Text('Add option'))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              //   Text("Select End Date:"),
              //   SizedBox(
              //     width: 10,
              //   ),
              //   SizedBox(
              //     width: 150,
              //     child: TextFormField(
              //       readOnly: true,
              //       textAlign: TextAlign.center,
              //       //keyboardType: TextInputType.text,
              //       decoration: InputDecoration(
              //         hintText: 'date',
              //         //'${value.p_date.year}/${value.p_date.month}/${value.p_date.day}',
              //         focusedBorder: UnderlineInputBorder(
              //           borderSide:
              //               BorderSide(color: Theme.of(context).primaryColor),
              //         ),
              //         hintStyle: TextStyle(
              //           fontSize: 14,
              //           color: Colors.black.withOpacity(0.50),
              //         ),
              //       ),
              //       validator: (value) {
              //         if (value!.isEmpty) {
              //           return 'Please Enter Quection';
              //         }

              //         return null;
              //       },
              //     ),
              //   ),
              //   // Text(
              //   //   '${date.year},${date.month},${date.month}',
              //   //   style: TextStyle(letterSpacing: 2, fontSize: 15),
              //   // ),
              //   IconButton(
              //       onPressed: () async {
              //         DateTime? newDate = await showDatePicker(
              //             context: context,
              //             initialDate: DateTime(2022, 8, 30),
              //             firstDate: DateTime(2021),
              //             lastDate: DateTime(2030));

              //         if (newDate == null) return;

              //         setState(() => DateTime(2022, 8, 30));
              //       },
              //       icon: Icon(Icons.date_range_outlined))
              // ]),

              Text(
                'Poll duration *',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),

              TextFormField(
                controller: _dateController,
                readOnly: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          // _dateController.text = _selectedValue.toString();
                        });

                        _showPicker(context);
                      },
                      icon: Icon(Icons.arrow_drop_down)),
                  border: OutlineInputBorder(),
                  //  hintText: 'Value: $_selectedValue',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.50),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Quection';
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                    text: 'Add Poll',
                    onPressed: () {
                      // if (value.pollvalidate()) {
                      //   print("ok");
                      //   value.postPoll();
                      //   Future.delayed(Duration(seconds: 2), () {
                      //     Navigator.of(context).pop();
                      //   });
                      // } else {
                      //   print("cancle");
                      // }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  int _selectedValue = 0;

  void _showPicker(BuildContext ctx) {
    showCupertinoModalBottomSheet(
        context: ctx,
        builder: (_) => Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: CupertinoPicker(
                    backgroundColor: Color.fromARGB(255, 230, 228, 228),
                    itemExtent: 30,
                    scrollController:
                        FixedExtentScrollController(initialItem: 1),
                    children: [
                      Text('1 Days'),
                      Text('3 Days'),
                      Text('7 Days'),
                      Text('2 Weeks'),
                    ],
                    onSelectedItemChanged: (value) {
                      print(value);
                      _selectedValue = value;

                      print(_dateController.text);
                      if (value == 0) {
                        _dateController.text = "1 Days";
                      } else if (value == 1) {
                        _dateController.text = "3 Days";
                      } else if (value == 2) {
                        _dateController.text = "7 Days";
                      } else if (value == 3) {
                        _dateController.text = "2 Weeks";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {});
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 152, 147, 147)),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(5)),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(fontSize: 12))),
                          child: Text("Done")),
                    ],
                  ),
                ),
              ],
            ));
  }
}
