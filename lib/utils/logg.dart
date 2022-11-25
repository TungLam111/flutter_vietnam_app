import 'dart:developer';

import 'package:flutter/material.dart';

void logg(dynamic thing) {
  log(thing.toString());
}

void pprint(dynamic thing) {
  debugPrint(thing.toString());
}
