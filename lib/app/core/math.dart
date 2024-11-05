class Math {
  static num calculate(num num1, num num2, String operator) {
    switch (operator) {
      case '+':
        return num1 + num2;
      case '-':
        return num1 - num2;
      case '*':
      case 'x':
        return num1 * num2;
      case '/':
        if (num2 == 0) {
          return 0;
        }
        return num1 / num2;
      case '%':
        return num1 % num2;
      default:
        throw ArgumentError("Operador desconhecido: $operator");
    }
  }
}
