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
}
