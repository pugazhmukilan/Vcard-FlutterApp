import 'package:flutter/material.dart';
class StackCover extends StatelessWidget {
  const StackCover({
    super.key,
    required this.colorscheme,
  });

  final ColorScheme colorscheme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: 300,
          height: 300,
          child: Stack(
            children: [
              // Top-Left
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 24,
                  height: 4,
                  color: colorscheme.tertiary,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 4,
                  height: 24,
                  color: colorscheme.tertiary,
                ),
              ),
      
              // Top-Right
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 24,
                  height: 4,
                  color: colorscheme.tertiary,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 4,
                  height: 24,
                  color: colorscheme.tertiary,
                ),
              ),
      
              // Bottom-Left
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: 24,
                  height: 4,
                  color: colorscheme.tertiary,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: 4,
                  height: 24,
                  color: colorscheme.tertiary,
                ),
              ),
      
              // Bottom-Right
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 24,
                  height: 4,
                  color: colorscheme.tertiary,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 4,
                  height: 24,
                  color: colorscheme.tertiary,
                ),
              ),
            ],
          ),
        ),
    );
  }
}