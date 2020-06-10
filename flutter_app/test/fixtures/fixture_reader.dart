import 'dart:io';

String fixture(String name) => File('text/fixtures/$name').readAsStringSync();
