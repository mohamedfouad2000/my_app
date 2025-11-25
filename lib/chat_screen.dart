import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//as
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Chat',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Root(),
    );
  }
}

class Root extends StatelessWidget {
  const Root({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        if (!snapshot.hasData) return const LoginPage();
        return const UsersListPage();
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtl = TextEditingController();
  final _passCtl = TextEditingController();
  bool _loading = false;

  Future<void> _login() async {
    setState(() => _loading = true);
    try {
      final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailCtl.text.trim(),
        password: _passCtl.text.trim(),
      );
      await _ensureUserDocument(cred.user!);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  Future<void> _register() async {
    if (!mounted) return; // لو الصفحة مش شغالة أصلاً
    setState(() => _loading = true);

    try {
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailCtl.text.trim(),
        password: _passCtl.text.trim(),
      );

      await _ensureUserDocument(cred.user!);

      // تأكد إن الصفحة لسه في الشجرة قبل أي setState أو Navigation
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/users');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      // التأكد التاني قبل setState النهائي
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  Future<void> _ensureUserDocument(User user) async {
    final doc = FirebaseFirestore.instance.collection('users').doc(user.uid);
    if (!(await doc.get()).exists) {
      await doc.set({
        'uid': user.uid,
        'displayName': user.displayName ?? user.email,
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login / Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: _emailCtl,
                decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 8),
            TextField(
                controller: _passCtl,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true),
            const SizedBox(height: 20),
            if (_loading) const CircularProgressIndicator(),
            if (!_loading)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: _login, child: const Text('Login')),
                  ElevatedButton(
                      onPressed: _register, child: const Text('Register')),
                ],
              )
          ],
        ),
      ),
    );
  }
}

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final _searchCtl = TextEditingController();

  @override
  void dispose() {
    _searchCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final me = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async => await FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: Column(
        children: [
          // 🔍 مربع بحث عن المستخدم
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchCtl,
                    decoration: const InputDecoration(
                      labelText: 'اكتب Email أو UID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _searchUserAndOpenChat,
                  child: const Text('بحث 🔍'),
                ),
              ],
            ),
          ),

          // 📜 قائمة المستخدمين العادية
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snap) {
                if (!snap.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final users =
                    snap.data!.docs.where((d) => d.id != me.uid).toList();

                if (users.isEmpty) {
                  return const Center(child: Text('مفيش مستخدمين تانين 👀'));
                }

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, i) {
                    final u = users[i].data();
                    final chatId = _chatIdFor(me.uid, u['uid']);
                    return ListTile(
                      title: Text(u['displayName'] ?? 'Unknown'),
                      subtitle: Text(u['email'] ?? ''),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatPage(
                            chatId: chatId,
                            otherUid: u['uid'],
                            otherName: u['displayName'] ?? '',
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ✅ دالة البحث وفتح الشات
  Future<void> _searchUserAndOpenChat() async {
    final input = _searchCtl.text.trim();
    if (input.isEmpty) return;

    final me = FirebaseAuth.instance.currentUser!;
    try {
      // 🔍 دور على اليوزر بالإيميل أو الـ UID
      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: input)
          .get();

      final userDoc = query.docs.isNotEmpty
          ? query.docs.first
          : await FirebaseFirestore.instance
              .collection('users')
              .doc(input)
              .get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        final chatId = _chatIdFor(me.uid, data['uid']);
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatPage(
              chatId: chatId,
              otherUid: data['uid'],
              otherName: data['displayName'] ?? data['email'] ?? 'User',
            ),
          ),
        );
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('المستخدم مش موجود ⚠️')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  String _chatIdFor(String a, String b) {
    final ids = [a, b]..sort();
    return '${ids[0]}_${ids[1]}';
  }
}

class ChatPage extends StatefulWidget {
  final String chatId;
  final String otherUid;
  final String otherName;
  const ChatPage(
      {super.key,
      required this.chatId,
      required this.otherUid,
      required this.otherName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _msgCtl = TextEditingController();
  final _scroll = ScrollController();

  Future<void> _send() async {
    final text = _msgCtl.text.trim();
    if (text.isEmpty) return;
    final me = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .collection('messages')
        .add({
      'text': text,
      'from': me.uid,
      'to': widget.otherUid,
      'createdAt': FieldValue.serverTimestamp(),
    });
    _msgCtl.clear();
    await Future.delayed(const Duration(milliseconds: 100));
    _scroll.jumpTo(_scroll.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    final me = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(title: Text(widget.otherName)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(widget.chatId)
                  .collection('messages')
                  .orderBy('createdAt')
                  .snapshots(),
              builder: (context, snap) {
                if (!snap.hasData)
                  return const Center(child: CircularProgressIndicator());
                final msgs = snap.data!.docs;
                return ListView.builder(
                  controller: _scroll,
                  itemCount: msgs.length,
                  itemBuilder: (context, i) {
                    final m = msgs[i].data();
                    final isMe = m['from'] == me.uid;
                    final time = (m['createdAt'] as Timestamp?)?.toDate();
                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue[200] : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(m['text'] ?? ''),
                            if (time != null)
                              Text(DateFormat('hh:mm a').format(time),
                                  style: const TextStyle(fontSize: 10)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                        controller: _msgCtl,
                        decoration:
                            const InputDecoration(hintText: 'Type a message')),
                  ),
                ),
                IconButton(onPressed: _send, icon: const Icon(Icons.send)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
