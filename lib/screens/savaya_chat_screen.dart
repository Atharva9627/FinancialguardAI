import 'package:flutter/material.dart';
import '../services/savaya_bot_service.dart';

class SavayaChatScreen extends StatefulWidget {
  const SavayaChatScreen({super.key});

  @override
  State<SavayaChatScreen> createState() => _SavayaChatScreenState();
}

class _SavayaChatScreenState extends State<SavayaChatScreen> {

  final TextEditingController controller = TextEditingController();

  List<Map<String,String>> messages = [];

  bool loading = false;

  Future<void> sendMessage() async {


    String question = controller.text.trim();

    if(question.isEmpty) return;

    setState(() {
    messages.add({"role":"user","text":question});
    loading = true;
    });

    controller.clear();

    String response = await SavayaBotService.askSavaya(question);

    setState(() {
    messages.add({"role":"bot","text":response});
    loading = false;
    });

  }

  @override
  Widget build(BuildContext context) {


    return Container(
    width: 320,
    height: 430,

    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    boxShadow: const [
    BoxShadow(
    color: Colors.black26,
    blurRadius: 12,
    )
    ],
    ),

    child: Column(
    children: [

    Container(
    padding: const EdgeInsets.all(14),

    decoration: const BoxDecoration(
    color: Color(0xFF0D47A1), // navy blue
    borderRadius: BorderRadius.vertical(
    top: Radius.circular(18),
    ),
    ),

    child: const Row(
    children: [

    Icon(
    Icons.smart_toy,
    color: Colors.white,
    ),

    SizedBox(width:10),

    Text(
    "Savaya AI Assistant",
    style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    ),
    )
    ],
    ),
    ),

    Expanded(
    child: ListView.builder(
    padding: const EdgeInsets.all(12),

    itemCount: messages.length,

    itemBuilder:(context,index){

    final msg = messages[index];

    bool isUser = msg["role"]=="user";

    return Align(
    alignment: isUser
    ? Alignment.centerRight
        : Alignment.centerLeft,

    child: Container(
    margin: const EdgeInsets.symmetric(vertical:6),

    padding: const EdgeInsets.all(12),

    decoration: BoxDecoration(

    color: isUser
    ? const Color(0xFF4FC3F7) // light blue
        : const Color(0xFFE3F2FD), // pale blue

    borderRadius: BorderRadius.circular(12),
    ),

    child: Text(
    msg["text"]!,

    style: TextStyle(
    color: isUser
    ? Colors.white
        : const Color(0xFF0D47A1),

    fontSize: 14,
    ),
    ),
    ),
    );
    },
    ),
    ),

    if(loading)
    const Padding(
    padding: EdgeInsets.only(bottom:6),
    child: CircularProgressIndicator(
    color: Color(0xFF4FC3F7),
    ),
    ),

    Container(
    padding: const EdgeInsets.symmetric(
    horizontal:10,
    vertical:6,
    ),

    decoration: const BoxDecoration(
    border: Border(
    top: BorderSide(
    color: Color(0xFFE0E0E0),
    ),
    ),
    ),

    child: Row(
    children: [

    Expanded(
    child: TextField(
      controller: controller,

      style: const TextStyle(
        color: Color(0xFF0D47A1), // navy blue text
        fontSize: 15,
      ),

      decoration: InputDecoration(
        hintText: "Ask Savaya anything...",

        hintStyle: const TextStyle(
          color: Colors.grey,
        ),

        filled: true,
        fillColor: const Color(0xFFF5F9FF),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    ),
    ),

    const SizedBox(width:8),

    Container(
    decoration: const BoxDecoration(
    color: Color(0xFF1976D2),
    shape: BoxShape.circle,
    ),

    child: IconButton(
    icon: const Icon(
    Icons.send,
    color: Colors.white,
    ),
    onPressed: sendMessage,
    ),
    )

    ],
    ),
    ),

    ],
    ),
    );


  }
}
