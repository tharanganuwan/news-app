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
  List<Student1> _studentList = [];
  Map<int, Student1> _studentMap = {};

  void _addNewStudent() {
    setState(() {
      _studentList.add(Student1('', 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.done,
          color: Colors.white,
        ),
        onPressed: () {
          if (_studentList.length != 0) {
            _studentList.forEach((student) => print(student.toString()));
          } else {
            print('map list empty');
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      appBar: AppBar(
        title: Text('Single Map Use'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              _addNewStudent();
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
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
              _addNewStudent();
            },
          ),
          Container(
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
                          IconButton(
                            icon: Icon(
                              Icons.remove,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                _studentList.removeAt(position);
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              _addNewStudent();
                            },
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
