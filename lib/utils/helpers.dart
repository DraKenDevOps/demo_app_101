String formatCurrency(double amount) {
  return "\$${amount.toStringAsFixed(2)}";
}

String formatDate(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}

String formatDateTime(DateTime date) {
  return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}:${date.second}";
}

bool isValidEmail(String email) {
  return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
}
