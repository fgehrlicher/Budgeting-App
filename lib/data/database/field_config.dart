class FieldConfig {
  String name;
  String config;

  FieldConfig(this.name, this.config);

  @override
  String toString() {
    return name + " " + config;
  }

}