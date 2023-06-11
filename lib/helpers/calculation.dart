import 'package:flutter/material.dart';

// Function to factorize a number and returns a map of 'factor:power' pairs
Map? factorize(number) {
  if (number != null) {
    Map<int, int> factors = {};
    int n;
    n = number;

    while (n != 1) {
      for (var i = 2; i < (n + 1); i++) {
        if (n.remainder(i) == 0) {
          if (factors.containsKey(i)) {
            factors.update(i, (value) => value + 1);
          } else {
            factors[i] = 1;
          }
          n = n ~/ i;
          break;
        }
      }
    }

    if (factors.isNotEmpty) {
      return factors;
    }
  }
  return null;
}

// Function to get factors and to represent them as 'factor --> (power)'
void calculate(int number, TextEditingController controller) {
  String data = "";

  Map? result = factorize(number);
  if (result != null) {
    result.forEach((key, value) {
      if (value == 1) {
        data = "$data$key --> ($value time)\n";
      } else {
        data = "$data$key --> ($value times)\n";
      }
    });
    int l = data.length;
    data = data.substring(0, l - 1);
  }
  controller.text = data;
}
