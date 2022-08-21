import 'package:flutter/material.dart';

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
  TextEditingController controller = TextEditingController();

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
      body: Column(
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
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.red,
            ),
            onPressed: () {
              for (int i = 0; i < controllrs.length; i++) {
                print(controllrs[i].text);
              }
            },
          ),
          Text("data"),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              color: Colors.amber,
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controllrs[position],

                                // initialValue: _studentMap[position].name.length != 0
                                //     ? _studentMap[position].name
                                // : '',
                                onFieldSubmitted: (name) {
                                  setState(() {
                                    _studentList[position].name = name;
                                    print("name");
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'enter student name',
                                  hintStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black26,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black12,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            (position == 0)
                                ? SizedBox()
                                : (position == 1)
                                    ? SizedBox()
                                    : (position + 1 == _studentList.length)
                                        ? IconButton(
                                            icon: Icon(
                                              Icons.remove,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                print("object");
                                                print(position);
                                                print("object");
                                                _studentList.removeAt(position);
                                                controllrs.remove(position);
                                              });
                                            },
                                          )
                                        : SizedBox(),
                            (position == 0)
                                ? SizedBox()
                                : (position + 1 == _studentList.length)
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          if (_studentList.length <= 5) {
                                            print("object");
                                            print(position);
                                            print("object");
                                            print("Length student" +
                                                _studentList.length.toString());
                                            _addNewStudent();
                                            controllrs
                                                .add(TextEditingController());
                                          }

                                          print(position);
                                        },
                                      )
                                    : SizedBox()
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
