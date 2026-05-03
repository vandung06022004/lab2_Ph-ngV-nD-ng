class CalculatorLogic {
  String display = '0';
  String equation = '';
  double num1 = 0;
  double num2 = 0;
  String operation = '';
  bool _shouldResetDisplay = false;
  bool _justPressedEquals = false;
  void onNumber(String number) {
    if (_shouldResetDisplay) {
      display = number;
      _shouldResetDisplay = false;
    } else {
      if (display.replaceAll('-', '').replaceAll('.', '').length >= 15) return;

      if (display == '0' && number != '.') {
        display = number;
      } else {
        display += number;
      }
    }
    _justPressedEquals = false;
  }
  void onOperation(String op) {
    if (_justPressedEquals) {
      num1 = double.tryParse(display) ?? 0;
      _justPressedEquals = false;
    } else if (operation.isNotEmpty && !_shouldResetDisplay) {
      _calculate();
      num1 = double.tryParse(display) ?? 0;
    } else {
      num1 = double.tryParse(display) ?? 0;
    }

    operation = op;
    equation = '${_formatNumber(num1)} $op';
    _shouldResetDisplay = true;
  }
  void onEquals() {
    if (operation.isEmpty) return;

    num2 = double.tryParse(display) ?? 0;
    equation = '${_formatNumber(num1)} $operation ${_formatNumber(num2)} =';

    _calculate();
    operation = '';
    _justPressedEquals = true;
    _shouldResetDisplay = true;
  }
  void _calculate() {
    double result;
    double operand = double.tryParse(display) ?? 0;

    switch (operation) {
      case '+':
        result = num1 + operand;
        break;
      case '-':
        result = num1 - operand;
        break;
      case '×':
        result = num1 * operand;
        break;
      case '÷':
        if (operand == 0) {
          display = 'Error';
          equation = 'Cannot divide by zero';
          operation = '';
          _shouldResetDisplay = true;
          return;
        }
        result = num1 / operand;
        break;
      default:
        return;
    }

    display = _formatNumber(result);
    num1 = result;
  }
  void onClear() {
    display = '0';
    equation = '';
    num1 = 0;
    num2 = 0;
    operation = '';
    _shouldResetDisplay = false;
    _justPressedEquals = false;
  }
  void onClearEnd() {
    if (_shouldResetDisplay || display == 'Error') {
      display = '0';
      _shouldResetDisplay = false;
      return;
    }

    if (display.length <= 1 || (display.length == 2 && display.startsWith('-'))) {
      display = '0';
    } else {
      display = display.substring(0, display.length - 1);
    }
  }
  void onDecimal() {
    if (_shouldResetDisplay) {
      display = '0.';
      _shouldResetDisplay = false;
      return;
    }
    if (!display.contains('.')) {
      display += '.';
    }
  }
  void onPlusMinus() {
    if (display == '0' || display == 'Error') return;

    if (display.startsWith('-')) {
      display = display.substring(1);
    } else {
      display = '-$display';
    }
  }
  void onPercentage() {
    if (display == 'Error') return;
    double value = double.tryParse(display) ?? 0;

    if (operation.isNotEmpty && !_shouldResetDisplay) {
      value = num1 * value / 100;
    } else {
      value = value / 100;
    }

    display = _formatNumber(value);
  }
  String _formatNumber(double value) {
    if (value.isNaN || value.isInfinite) return 'Error';
    if (value == value.truncateToDouble()) {
      String intStr = value.toInt().toString();
      // Limit length
      if (intStr.length > 15) return value.toStringAsExponential(6);
      return intStr;
    }

    // Format with up to 10 decimal places, removing trailing zeros
    String formatted = value.toStringAsFixed(10);
    formatted = formatted.replaceAll(RegExp(r'0+$'), '');
    formatted = formatted.replaceAll(RegExp(r'\.$'), '');

    if (formatted.length > 15) return value.toStringAsExponential(6);
    return formatted;
  }
}
