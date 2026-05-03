import 'package:flutter/material.dart';
import 'app_colors.dart';

enum ButtonType { number, operation, special, equals }

class CalculatorButton extends StatefulWidget {
  final String label;
  final ButtonType type;
  final VoidCallback onTap;
  final bool isWide;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.type,
    required this.onTap,
    this.isWide = false,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Color _getBackgroundColor() {
    switch (widget.type) {
      case ButtonType.number:
        return AppColors.secondary;
      case ButtonType.operation:
        return AppColors.accent;
      case ButtonType.special:
        return AppColors.primary.withOpacity(0.7);
      case ButtonType.equals:
        return AppColors.accent;
    }
  }

  Color _getTextColor() {
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _animController.forward(),
      onTapUp: (_) {
        _animController.reverse();
        widget.onTap();
      },
      onTapCancel: () => _animController.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                color: _getTextColor(),
                fontSize: 22,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
