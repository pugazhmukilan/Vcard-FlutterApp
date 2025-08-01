List<String> parseString(String input) {
  if (input.isEmpty) {
    return [];
  }

  // Remove leading and trailing whitespace
  input = input.trim();

  // Replace multiple spaces with a single space
  List<String> userInfo = input.split("|");
  //print(userInfo[0]);

  return userInfo;
}