import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'calculator_button.dart';
import 'calculator_logic.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorLogic _logic = CalculatorLogic();
  void _handleAction(VoidCallback action) {
    setState(() {
      action();
    });
  }
  Widget _buildDisplay() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      decoration: const BoxDecoration(
        color: AppColors.displayBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              _logic.equation.isEmpty ? ' ' : _logic.equation,
              style: const TextStyle(
                color: AppColors.equationText,
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              _logic.display,
              style: TextStyle(
                color: _logic.display == 'Error'
                    ? Colors.redAccent
                    : AppColors.displayText,
                fontSize: _logic.display.length > 10 ? 32 : 48,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonGrid() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildRow([
            _btn('C', ButtonType.special, () => _handleAction(_logic.onClear)),
            _btn('CE', ButtonType.special, () => _handleAction(_logic.onClearEnd)),
            _btn('%', ButtonType.special, () => _handleAction(_logic.onPercentage)),
            _btn('÷', ButtonType.operation, () => _handleAction(() => _logic.onOperation('÷'))),
          ]),
          const SizedBox(height: 16),
          _buildRow([
            _btn('7', ButtonType.number, () => _handleAction(() => _logic.onNumber('7'))),
            _btn('8', ButtonType.number, () => _handleAction(() => _logic.onNumber('8'))),
            _btn('9', ButtonType.number, () => _handleAction(() => _logic.onNumber('9'))),
            _btn('×', ButtonType.operation, () => _handleAction(() => _logic.onOperation('×'))),
          ]),
          const SizedBox(height: 16),
          _buildRow([
            _btn('4', ButtonType.number, () => _handleAction(() => _logic.onNumber('4'))),
            _btn('5', ButtonType.number, () => _handleAction(() => _logic.onNumber('5'))),
            _btn('6', ButtonType.number, () => _handleAction(() => _logic.onNumber('6'))),
            _btn('-', ButtonType.operation, () => _handleAction(() => _logic.onOperation('-'))),
          ]),
          const SizedBox(height: 16),
          _buildRow([
            _btn('1', ButtonType.number, () => _handleAction(() => _logic.onNumber('1'))),
            _btn('2', ButtonType.number, () => _handleAction(() => _logic.onNumber('2'))),
            _btn('3', ButtonType.number, () => _handleAction(() => _logic.onNumber('3'))),
            _btn('+', ButtonType.operation, () => _handleAction(() => _logic.onOperation('+'))),
          ]),
          const SizedBox(height: 16),
          _buildLastRow(),
        ],
      ),
    );
  }
  Widget _buildRow(List<Widget> buttons) {
    return Row(
      children: buttons
          .map((btn) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(height: 72, child: btn),
                ),
              ))
          .toList(),
    );
  }
  Widget _buildLastRow() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              height: 72,
              child: _btn('±', ButtonType.special,
                  () => _handleAction(_logic.onPlusMinus)),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              height: 72,
              child: _btn('0', ButtonType.number,
                  () => _handleAction(() => _logic.onNumber('0'))),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              height: 72,
              child: _btn(
                  '.', ButtonType.number, () => _handleAction(_logic.onDecimal)),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              height: 72,
              child: _btn('=', ButtonType.equals,
                  () => _handleAction(_logic.onEquals)),
            ),
          ),
        ),
      ],
    );
  }
  Widget _btn(String label, ButtonType type, VoidCallback onTap) {
    return CalculatorButton(label: label, type: type, onTap: onTap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  Text(
                    'Calculator',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            _buildDisplay(),
            const Spacer(),
            _buildButtonGrid(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
