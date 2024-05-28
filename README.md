# hive_database_demo

**Hive Database:**
- Local Storage
- faster
- it's No Sql Database
- key-value database
- used for small project
- it's create boxes. likes file and each data store in boxes.
- for hive database we need to create TypeAdapter. and need to register adapter using Hive.registerAdapter(adapter_name)
- it's provide strong encryption for data.
- no native relationship
- we can't perform complex query.

## Getting Started

- add dependency
```dart
hive:
path_provider:
```

```dart
dev_dependencies:
  hive_flutter:
  flutter_test:
    sdk: flutter
```

- add permission in AndroidManifest.xml
```dart
    <uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```
- initialize hive database
```dart
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
```