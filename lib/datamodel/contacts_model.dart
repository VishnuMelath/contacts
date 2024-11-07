class ContactsModel {
  final String id;
  final String firstName;
  final String surname;
  final List<String> numbers;
  final String company;
  bool fav;

  ContactsModel(
      {required this.id,
      required this.firstName,
      required this.surname,
      required this.numbers,
      required this.company,
      required this.fav});
  Map<String, String> toMap() {
    return {
      'id': id,
      'firstname': firstName,
      'surname': surname,
      'numbers': combine(numbers),
      'company': company,
      'fav': fav.toString()
    };
  }

  factory ContactsModel.fromMap(Map<String, dynamic> map) {
    return ContactsModel(
        id: map['id'],
        firstName: map['firstname'],
        surname: map['surname'],
        numbers: splitNumbers(map['numbers']),
        company: map['company'],
        fav: bool.parse(map['fav']));
  }

  String combine(List<String> numbers) {
    String result = '';
    for (var element in numbers) {
      result = '$result#$element';
    }
    return result;
  }

  static List<String> splitNumbers(String combinednums) {
    var result = combinednums.split('#');
    result.removeWhere(
      (element) => element == '',
    );
    return result;
  }
}
