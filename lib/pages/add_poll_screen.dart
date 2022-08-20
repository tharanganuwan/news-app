import 'package:animate_do/animate_do.dart';
import 'package:cybehawks/controller/post_controller.dart';
import 'package:cybehawks/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../components/primary_button.dart';

class AddPollsScreen extends StatefulWidget {
  const AddPollsScreen({Key? key}) : super(key: key);

  @override
  State<AddPollsScreen> createState() => _AddPollsScreenState();
}

class _AddPollsScreenState extends State<AddPollsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FadeInUp(
      child: Consumer<PostController>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    'Create Poll',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Your quection *',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                TextFormField(
                  controller: value.questionController,
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
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: value.ans1Controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Answer 1',
                    border: OutlineInputBorder(),
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
                TextFormField(
                  controller: value.ans2Controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Answer 2',
                    border: OutlineInputBorder(),
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
                TextFormField(
                  controller: value.ans3Controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Answer 3',
                    border: OutlineInputBorder(),
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
                TextFormField(
                  controller: value.ans4Controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Answer 4',
                    border: OutlineInputBorder(),
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
                  height: 20,
                ),
                Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Select End Date:"),
                      SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        width: 170,
                        child: TextFormField(
                          readOnly: true,
                          textAlign: TextAlign.center,
                          //keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText:
                                '${value.p_date.year}/${value.p_date.month}/${value.p_date.day}',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
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
                      ),
                      // Text(
                      //   '${date.year},${date.month},${date.month}',
                      //   style: TextStyle(letterSpacing: 2, fontSize: 15),
                      // ),
                      IconButton(
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: value.p_date,
                                firstDate: DateTime(2021),
                                lastDate: DateTime(2030));

                            if (newDate == null) return;

                            setState(() => value.setdate(newDate));
                          },
                          icon: Icon(Icons.date_range_outlined))
                    ]),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                      text: 'Add Poll',
                      onPressed: () {
                        if (value.pollvalidate()) {
                          print("ok");
                          value.postPoll();
                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.of(context).pop();
                          });
                        } else {
                          print("cancle");
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
