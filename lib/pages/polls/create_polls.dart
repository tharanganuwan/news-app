import 'package:cybehawks/controller/post_controller.dart';
import 'package:cybehawks/pages/home.dart';
import 'package:cybehawks/pages/polls/view_polls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../components/primary_button.dart';

class CreatePoll extends StatefulWidget {
  const CreatePoll({Key? key}) : super(key: key);

  @override
  State<CreatePoll> createState() => _CreatePollState();
}

class _CreatePollState extends State<CreatePoll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Create Polls 🗳')),
        body: Consumer<PostController>(
          builder: (context, value, child) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: value.questionController,
                    maxLines: 2,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Quection',
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: value.ans1Controller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Answer 1',
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
                        TextFormField(
                          controller: value.ans2Controller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Answer 2',
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
                        TextFormField(
                          controller: value.ans3Controller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Answer 3',
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
                        TextFormField(
                          controller: value.ans4Controller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Answer 4',
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
                      ],
                    ),
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
        ));
  }
}
