import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';
import 'package:sign_checker/HomePage/cameraPage.dart';

class StateSelectionPage extends StatefulWidget {
  const StateSelectionPage({super.key, this.redirectBack = false});
  final bool redirectBack;

  @override
  _StateSelectionPageState createState() => _StateSelectionPageState();
}

class _StateSelectionPageState extends State<StateSelectionPage> {
  String? selectedState;
  List<String> allStates = ['US', 'UK']; // Add more states if needed

  @override
  void initState() {
    super.initState();
    loadSelectedState();
  }

  Future<void> loadSelectedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedState = prefs.getString('selectedState');
    });
  }

  Future<void> saveSelectedState(String state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedState', state);
    setState(() {
      selectedState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select State',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: allStates.length,
              itemBuilder: (BuildContext context, int index) {
                final state = allStates[index];

                return InkWell(
                  onTap: () {
                    saveSelectedState(state);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(state),
                        Radio(
                          value: state,
                          groupValue: selectedState,
                          onChanged: (String? newValue) {
                            saveSelectedState(newValue!);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16.0, top: 10.0), // Add margin to the bottom
            child: ElevatedButton(
              onPressed: () async {
                if (selectedState != null) {
                  if (widget.redirectBack) {
                    Navigator.pop(context);
                  } else {
                    await availableCameras().then((value) =>
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) =>
                                CameraPage(cameras: value))));
                  }
                }
              },
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
