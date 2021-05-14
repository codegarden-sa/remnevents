import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/constants/constants.dart';
import 'package:sandtonchurchapp/screens/authenticate/profile.dart';

class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    color: AppConstants.lightgrey,
                    padding: EdgeInsets.all(12.0),
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Departmental Leaders',
                            style: TextStyle(color: AppConstants.darkblue)),
                        Icon(
                          Icons.arrow_forward_rounded,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                )),
          ],
        ),
      ),
    );
  }
}
