String calculateDv(String number) {
  final sequence = [2, 3, 4, 5, 6, 7];
  int sum = 0;
  for (int i = number.length - 1, j = 0; i >= 0; i--, j++) {
    sum += int.parse(number[i]) * sequence[j % sequence.length];
  }
  final remainder = sum % 11;
  final digit = 11 - remainder;

  if (digit == 11) return '0';
  if (digit == 10) return 'K';

  return digit.toString();
}
