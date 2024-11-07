import 'package:flutter/material.dart';

class CustomSaveButton extends StatelessWidget {
  final VoidCallback onSave;
  final bool isLoading;

  const CustomSaveButton({
    super.key,
    required this.onSave,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onSave,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      child: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.save,
                  size: 20,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text('Save'),
              ],
            ),
    );
  }
}
