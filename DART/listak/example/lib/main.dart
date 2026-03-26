import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const TicTacToePage(),
    );
  }
}

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({super.key});

  @override
  State<TicTacToePage> createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  String _winner = '';
  bool _isDraw = false;
  bool _gameOver = false;

  int _xWins = 0;
  int _oWins = 0;
  int _draws = 0;

  void _makeMove(int index) {
    if (_board[index].isNotEmpty || _gameOver) return;

    setState(() {
      _board[index] = _currentPlayer;

      if (_checkWinner()) {
        _winner = _currentPlayer;
        _gameOver = true;
        if (_winner == 'X') {
          _xWins++;
        } else {
          _oWins++;
        }
      } else if (_checkDraw()) {
        _isDraw = true;
        _gameOver = true;
        _draws++;
      } else {
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      }
    });
  }

  bool _checkWinner() {
    const List<List<int>> winningPatterns = [
      [0, 1, 2], // sorok
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6], // oszlopok
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8], // átlók
      [2, 4, 6],
    ];

    for (final pattern in winningPatterns) {
      final a = pattern[0];
      final b = pattern[1];
      final c = pattern[2];

      if (_board[a].isNotEmpty &&
          _board[a] == _board[b] &&
          _board[b] == _board[c]) {
        return true;
      }
    }
    return false;
  }

  bool _checkDraw() {
    return _board.every((cell) => cell.isNotEmpty);
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _currentPlayer = 'X';
      _winner = '';
      _isDraw = false;
      _gameOver = false;
    });
  }

  void _openStatsPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => StatsPage(xWins: _xWins, oWins: _oWins, draws: _draws),
      ),
    );
  }

  String get _statusText {
    if (_winner.isNotEmpty) return 'Nyertes: $_winner!';
    if (_isDraw) return 'Döntetlen!';
    return 'Következő játékos: $_currentPlayer';
  }

  Color _symbolColor(String value) {
    if (value == 'X') return Colors.indigo;
    if (value == 'O') return Colors.deepOrange;
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final boardSize = width > 500 ? 420.0 : width * 0.9;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic-Tac-Toe'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Statisztika',
            onPressed: _openStatsPage,
            icon: const Icon(Icons.bar_chart_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _statusText,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: boardSize,
                    height: boardSize,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 9,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                      itemBuilder: (context, index) {
                        final value = _board[index];
                        return InkWell(
                          onTap: () => _makeMove(index),
                          borderRadius: BorderRadius.circular(16),
                          child: Ink(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest
                                  .withValues(alpha: 0.55),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).colorScheme.outline.withValues(alpha: 0.35),
                              ),
                            ),
                            child: Center(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 180),
                                transitionBuilder: (child, animation) =>
                                    ScaleTransition(
                                      scale: animation,
                                      child: child,
                                    ),
                                child: Text(
                                  value,
                                  key: ValueKey(value + index.toString()),
                                  style: TextStyle(
                                    fontSize: boardSize * 0.15,
                                    fontWeight: FontWeight.w800,
                                    color: _symbolColor(value),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: _resetGame,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Új játék'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StatsPage extends StatelessWidget {
  const StatsPage({
    super.key,
    required this.xWins,
    required this.oWins,
    required this.draws,
  });

  final int xWins;
  final int oWins;
  final int draws;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statisztika'), centerTitle: true),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _StatCard(
                title: 'X győzelmek',
                value: xWins,
                color: Colors.indigo,
                icon: Icons.close_rounded,
              ),
              const SizedBox(height: 12),
              _StatCard(
                title: 'O győzelmek',
                value: oWins,
                color: Colors.deepOrange,
                icon: Icons.radio_button_unchecked_rounded,
              ),
              const SizedBox(height: 12),
              _StatCard(
                title: 'Döntetlenek',
                value: draws,
                color: Colors.teal,
                icon: Icons.handshake_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  final String title;
  final int value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        trailing: Text(
          '$value',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ),
    );
  }
}
