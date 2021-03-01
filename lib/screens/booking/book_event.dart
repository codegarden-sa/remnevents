import 'package:flutter/material.dart';
import '../../controller/form_controller.dart';
import '../../models/form.dart';
import '../calendar/calendar_events.dart';

class BookEvent extends StatefulWidget {
  @override
  _BookEventState createState() => _BookEventState();
}

class _BookEventState extends State<BookEvent> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController eventController = TextEditingController();
  TextEditingController venueController = TextEditingController();
  //TextEditingController departmentController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      FeedbackForm feedbackForm = FeedbackForm(
        startDateController.text,
        endDateController.text,
        timeController.text,
        departmentController.text,
        eventController.text,
        venueController.text,
      );

      FormController formController = FormController((String response) {
        if (response == FormController.STATUS_SUCCESS) {
          //
          _showSnackbar("Feedback Submitted");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CalendarEvents()));
        } else {
          _showSnackbar("Error Occurred!");
        }
      });

      _showSnackbar("Submitting Feedback");
      formController.submitForm(feedbackForm);
    }
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: startDateController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Valid Name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Start Date"),
                        ),
                        TextFormField(
                          controller: endDateController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Valid Email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "End Date"),
                        ),
                        TextFormField(
                          controller: timeController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Valid Phone Number";
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Time"),
                        ),
                        TextFormField(
                          controller: departmentController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Valid Feedback";
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Department"),
                        ),
                        TextFormField(
                          controller: eventController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Valid Feedback";
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Event"),
                        ),
                        TextFormField(
                          controller: venueController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Valid Feedback";
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Venue"),
                        ),
                        RaisedButton(
                          color: Color.fromRGBO(7, 94, 84, 1.0),
                          textColor: Colors.white,
                          onPressed: _submitForm,
                          child: Text('Submit Feedback'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
