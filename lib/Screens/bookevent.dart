import 'package:asquareevents/Screens/eventLogin.dart';
import 'package:asquareevents/widgets/decostyle.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:asquareevents/models/dropdown.dart';

class Eventbook extends StatefulWidget {
  @override
  _EventbookState createState() => _EventbookState();
}

class _EventbookState extends State<Eventbook> {
  String eventname,
      eventlocation,
      startdate,
      enddate,
      eventdescription,
      eventcategory;

  Eventdrop selectedUser;
  List<Eventdrop> users = <Eventdrop>[
    const Eventdrop('Seminar'),
    const Eventdrop('Workshop'),
    const Eventdrop('Entertainment'),
  ];

  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _dateControllers = TextEditingController();
  ValueNotifier<DateTime> _dateTimeNotifier =
      ValueNotifier<DateTime>(DateTime.now());

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  DateTime selecteddate = DateTime.now();
  DateTime selectedenddate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
            context: context,
            initialDate: selecteddate,
            firstDate: DateTime(2019, 8),
            lastDate: DateTime(2100))
        .then((DateTime dateTime) => _dateTimeNotifier.value = dateTime);
    if (picked != null && picked != selecteddate)
      setState(() {
        selecteddate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dateController.text = date;
      });
  }

  _selectendDate(BuildContext context) async {
    final DateTime pickedd = await showDatePicker(
        context: context,
        initialDate: selectedenddate,
        firstDate: _dateTimeNotifier.value,
        lastDate: DateTime(2022));
    if (pickedd != null && pickedd != selectedenddate)
      setState(() {
        selectedenddate = pickedd;
        var dates =
            "${pickedd.toLocal().day}/${pickedd.toLocal().month}/${pickedd.toLocal().year}";
        _dateControllers.text = dates;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Make Your Event Special',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: buildInputDecoration(Icons.event, "Event Name"),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Event Name';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      eventname = value;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: buildInputDecoration(
                        Icons.event_seat, "Event Location"),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Event Location';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      eventlocation = value;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _dateController,
                        keyboardType: TextInputType.datetime,
                        decoration: buildInputDecoration(
                            Icons.calendar_today, "Event Start Date"),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter valid start date';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          startdate = value;
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: GestureDetector(
                    onTap: () => _selectendDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _dateControllers,
                        keyboardType: TextInputType.datetime,
                        decoration: buildInputDecoration(
                            Icons.calendar_today_rounded, "Event End Date"),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter valid end date';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          enddate = value;
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    minLines: 4,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: buildInputDecoration(
                        Icons.event_note, "Event Description"),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Event Description';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      eventdescription = value;
                    },
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                    child: DropdownButtonFormField<Eventdrop>(
                      decoration: buildInputDecoration(
                          Icons.category, "Event Category"),
                      // hint: Text("Select Event"),
                      value: selectedUser,
                      onChanged: (Eventdrop Value) {
                        setState(() {
                          selectedUser = Value;
                        });
                      },
                      items: users.map((Eventdrop user) {
                        return DropdownMenuItem<Eventdrop>(
                          value: user,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                user.name,
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    )),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.redAccent,
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        print("successful");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Loginuser()));

                        return;
                      } else {
                        print("UnSuccessfull");
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Colors.blue, width: 2)),
                    textColor: Colors.white,
                    child: Text("Book Event"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
