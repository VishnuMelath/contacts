import 'package:flutter/material.dart';

class ContactAddedSnackbar extends StatelessWidget {
  final String message;

  const ContactAddedSnackbar({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Material(
          borderRadius: BorderRadius.circular(8.0),
          elevation: 6.0,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.green.shade600,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                  size: 24.0,
                ),
                const SizedBox(width: 8.0),
                Flexible(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showContactAddedSnackbar(BuildContext context, String contactName,
    [bool add = true]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: ContactAddedSnackbar(
        message:
            add ? '$contactName added to contacts' : 'Updated successfully',
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}

class ContactDeletedSnackbar extends StatelessWidget {
  final String message;

  const ContactDeletedSnackbar({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Material(
          borderRadius: BorderRadius.circular(8.0),
          elevation: 6.0,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.red.shade600,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 24.0,
                ),
                const SizedBox(width: 8.0),
                Flexible(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showContactDeletedSnackbar(BuildContext context, String contactName,
    [String? message]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: ContactDeletedSnackbar(
        message: message ?? '$contactName deleted from contacts',
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}
