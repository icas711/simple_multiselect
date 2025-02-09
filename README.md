# Simple Multi Select

Flutter package for multi-select UI widget


https://github.com/user-attachments/assets/76a1b68e-54e3-4ce8-ae94-dee7420e1323




## Features

- Accepts custom input data.
- Data is updated when selected.
- BottomSheet.

## Getting started

- Add the package into `pubspec.yaml`

```yaml
dependencies:
  simple_multiselect:
```

- Import in your code

```dart
import 'package:flutter_multiselect/flutter_multiselect.dart';
```

## Usage

Create class with data and override method "toString()"
If need to display only name, example: 

```dart
class User {
  final String id;
  final String title;
  final String email;

  const User({required this.id, required this.title, required this.email});

  @override
  String toString() {
    return title;
  }
}
```
Decorate the widget as needed.
Add the SimpleMultiselect widget to your build method:

```dart
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    border: Border.all(color: Colors.black),
  ),
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
  child: SimpleMultiselect<User>(
    labelBackgroundColor: Colors.lightGreen.shade300,
    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
    dataSource: users,
    onChange: (value) => print(value),
    closeButtonText: 'Close',
  ),
)
}
```

