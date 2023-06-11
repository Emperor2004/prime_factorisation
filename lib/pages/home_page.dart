import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prime_factorisation/helpers/calculation.dart';
import 'package:prime_factorisation/helpers/widgets.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController inputController = TextEditingController();
  TextEditingController outputController = TextEditingController();
  ScrollController scrollController = ScrollController();
  String errorStatement = "";

  @override
  void dispose() {
    super.dispose();
    inputController.dispose();
    outputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Text Field to input number
                  TextField(
                    showCursor: true,
                    controller: inputController,
                    keyboardType: TextInputType.number,
                    onChanged: (text) => {
                      if (text == "")
                        {outputController.text = "", errorStatement = ""}
                    },
                    decoration: InputDecoration(
                      labelText: "Write Number Here...",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          setState(() {
                            inputController.clear();
                            outputController.clear();
                          });
                        },
                      ),
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                    ),
                  ),

                  // Error text custom widget
                  errorTextWidget(errorStatement),

                  // Button to calculate factors
                  ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          String inputText = inputController.text.toString();
                          try {
                            if (!inputText.contains(" ")) {
                              if (!inputText.contains(".") &
                                  !inputText.contains("-", 0)) {
                                if (inputText.contains("+", 0)) {
                                  inputText = inputText.replaceFirst("+", "");
                                }
                                int inputNum = int.parse(inputText);
                                if (inputNum >= 2) {
                                  outputController.text = "";
                                  errorStatement = "";
                                  calculate(inputNum, outputController);
                                } else {
                                  errorStatement =
                                      "Integer should be greater than 1";
                                }
                              } else {
                                errorStatement =
                                    "Input should be a Positive Integer";
                              }
                            } else {
                              errorStatement = "Remove the spaces";
                            }
                          } catch (e) {
                            errorStatement = "Enter number in correct format";
                          }
                        });
                      },
                      icon: const Icon(Icons.api_rounded),
                      label: const Text("Let's Prime Factorize...")),

                  // Text Field to display result
                  TextField(
                      scrollController: scrollController,
                      scrollPhysics: const BouncingScrollPhysics(),
                      readOnly: true,
                      controller: outputController,
                      maxLines: null,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.copy_all_rounded),
                            onPressed: () {
                              setState(() {
                                String copytext =
                                    "Prime Factors of ${inputController.text} =>\n\n${outputController.text}";
                                Clipboard.setData(ClipboardData(text: copytext))
                                    .then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Copied to Clipboard")));
                                });
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0))))
                ]),
          ),
        ),
      ),
    );
  }
}
