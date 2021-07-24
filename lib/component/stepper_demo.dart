import 'package:flutter/material.dart';

class StepperDemo extends StatefulWidget {
  const StepperDemo({Key? key}) : super(key: key);

  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("stepper".toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Theme(
                  data: Theme.of(context).copyWith(
                    primaryColor: Colors.black,
                  ),
                  child: Stepper(
                    currentStep: _currentStep,
                    onStepTapped: (value) {
                      setState(() {
                        _currentStep = value;
                      });
                    },
                    onStepContinue: () {
                      print(_currentStep);
                      if (0 <= _currentStep && _currentStep <= 4) {
                        setState(() {
                          if(_currentStep==0) {
                            _currentStep+=2;
                          }else{
                            _currentStep++;
                          }
                          if(  _currentStep>4){
                            _currentStep=0;
                          }
                        });
                      }
                    },
                    steps: [
                      Step(
                          title: Text("error"),
                          subtitle: Text("subtitle"),
                          state: StepState.error,
                          isActive: 0 == _currentStep,
                          content: Text("step content")),
                      Step(
                          title: Text("disabled"),
                          state: StepState.disabled,
                          isActive: 1 == _currentStep,
                          content: Text("step content")),
                      Step(
                          title: Text("complete"),
                          state: StepState.complete,
                          isActive: 2 == _currentStep,
                          content: Text("step content")),
                      Step(
                          title: Text("editing"),
                          state: StepState.editing,
                          isActive: 3 == _currentStep,
                          content: Text("step content")),
                      Step(
                          title: Text("indexed"),
                          state: StepState.indexed,
                          isActive: 4== _currentStep,
                          content: Text("step content")),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
