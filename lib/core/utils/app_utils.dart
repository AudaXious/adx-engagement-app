String shortenString(String input, int maxLength) {
  if (input.length <= maxLength) {
    return input;
  }
  return '${input.substring(0, maxLength)}...';
}