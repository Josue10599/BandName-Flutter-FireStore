import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['vote'] != null),
        name = map['name'],
        votes = map['vote'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => 'Record<$name:$votes>';

  increment() => reference.updateData({'vote': FieldValue.increment(1)});
  decrement() => reference.updateData({'vote': FieldValue.increment(-1)});
}
