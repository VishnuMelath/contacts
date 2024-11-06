class ContactsModel {
  final String firstName;
  final String surname;
  final List<String> numbers;
  final String company;

  ContactsModel(
      {required this.firstName,
      required this.surname,
      required this.numbers,
      required this.company});
  Map<String, String> toMap() {
    return {
      'firstname': firstName,
      'surname': surname,
      'numbers': combine(numbers),
      'company': company
    };
  }

  String combine(List<String> numbers) {
    String result = '';
    for (var element in numbers) {
      result = '$result#$element';
    }
    return result;
  }

  List<String> splitNumbers(String combinednums) {
    var result = combinednums.split('#');
    return result;
  }
}
