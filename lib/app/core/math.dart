class Math {
  static num calculate(num num1, num num2, String operator) {
    //construtor recebe o primeiro valor operador e segundo valor
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
        return num1 *
            (num2 / 100); //pega a porcentagem do primeiro valor sobre o segundo
      default:
        throw ArgumentError("Operador desconhecido: $operator");
    }
  }

  static num parseInput(String input) {
    return num.tryParse(input.replaceAll(',', '.')) ?? 0;
  }
}
