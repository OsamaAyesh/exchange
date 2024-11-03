class DataTypeProcess {
  final String id; // Assuming you have an id property
  final String name;

  DataTypeProcess({required this.id, required this.name});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DataTypeProcess) return false;
    return id == other.id; // Compare by id
  }

  @override
  int get hashCode => id.hashCode; // Use id for hashCode
}
