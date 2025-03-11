import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PomoScreen extends StatefulWidget {
  const PomoScreen({super.key});

  @override
  State<PomoScreen> createState() => _PomoScreenState();
}

class _PomoScreenState extends State<PomoScreen> {
  static const pomodoroTime = 3;
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? validationMessage;
  late Timer? timer;
  int totalSeconds = pomodoroTime;
  bool isRunning = false;
  bool isFinished = false;
  String _today = "";

  @override
  void initState() {
    super.initState();

    DateTime today = DateTime.now();
    setState(() {
      _today = DateFormat('yyyy.MM.dd EEEE', 'ko_KR').format(today);
    });
  }

  @override
  void dispose() {
    _textController.dispose(); //메모리 해제
    super.dispose();
  }

  void onTick(Timer timer) {
    totalSeconds = totalSeconds - 1;
    if (totalSeconds == 0) {
      isFinished = true;
      timer.cancel();
    }

    setState(() {});
  }

  void onStartOrStopPressed() {
    setState(() {
      isRunning = !isRunning;
    });

    if (isRunning) {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        onTick,
      );
    } else {
      timer?.cancel();
    }
  }

  void onResetPressed() {
    setState(() {
      totalSeconds = pomodoroTime;
      isRunning = false;
      isFinished = false;
      timer?.cancel();
    });
  }

  String formatPomoTime(int seconds) {
    Duration time = Duration(seconds: seconds);
    return time.toString().split('.').first.substring(2, 7);
  }

  void onSavePressed() {
    // API 연동 후 주석 제거하기
    // if (_formKey.currentState!.validate()) {
    //   debugPrint('토마토: ${_textController.text}');
    // } else {
    //   setState(() {
    //     validationMessage = '태그 입력 후 저장해주세요!';
    //   });
    //   return;
    // }

    onResetPressed();
  }

  @override
  Widget build(BuildContext context) {
    double pomodoroTimerWidth = MediaQuery.of(context).size.width * 0.75;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          _today,
          style: const TextStyle(
            fontSize: 15,
            letterSpacing: -0.3,
          ),
        ),
        Container(
          width: pomodoroTimerWidth,
          height: pomodoroTimerWidth,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red,
              width: 14,
            ),
            color: Colors.red,
            borderRadius: BorderRadius.circular(pomodoroTimerWidth / 2),
          ),
          child: Center(
            child: Text(
              isFinished ? "🍅" : formatPomoTime(totalSeconds),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                // color: Colors.green,
              ),
            ),
          ),
        ),
        if (!isFinished)
          SizedBox(
            height: 170,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onStartOrStopPressed,
                  child: Container(
                    width: 140,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isRunning ? '정지' : '시작',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onResetPressed,
                  child: Container(
                    width: 140,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '초기화',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (isFinished)
          SizedBox(
            height: 170,
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: _textController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "태그 입력 후 저장해주세요!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        labelText: '# 태그를 입력해 주세요', // 입력란에 라벨을 추가
                        labelStyle: TextStyle(
                          fontSize: 12,
                          letterSpacing: -0.1,
                          color: Colors.grey.shade500,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        errorStyle: const TextStyle(color: Colors.red),
                      ),
                      cursorErrorColor: Colors.red,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onSavePressed,
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '🍅 저장하고 스탬프 받기',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
