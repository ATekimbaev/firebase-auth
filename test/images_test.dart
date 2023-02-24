import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_app/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.mountain).existsSync(), true);
    expect(File(Images.ship).existsSync(), true);
    expect(File(Images.sun).existsSync(), true);
    expect(File(Images.tree).existsSync(), true);
    expect(File(Images.tree2).existsSync(), true);
  });
}
