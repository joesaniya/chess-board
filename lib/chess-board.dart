import 'package:flutter/material.dart';

class ChessBoardView extends StatefulWidget {
  const ChessBoardView({super.key});

  @override
  State<ChessBoardView> createState() => _ChessBoardViewState();
}

class _ChessBoardViewState extends State<ChessBoardView> {
  List<List<String?>> board = List.generate(8, (_) => List.filled(8, null));

  String? selectedPiece;
  int? selectedRow;
  int? selectedCol;

  @override
  void initState() {
    super.initState();
    InitialBoard();
  }

  void InitialBoard() {
    board[0] = ['r', 'n', 'b', 'q', 'k', 'b', 'n', 'r'];
    board[1] = List.filled(8, 'p');
    board[6] = List.filled(8, 'P');
    board[7] = ['R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R'];
  }

  void _selectSquare(int row, int col) {
    setState(() {
      if (selectedPiece == null) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      } else {
        board[selectedRow!][selectedCol!] = null;
        board[row][col] = selectedPiece;
        selectedPiece = null;
        selectedRow = null;
        selectedCol = null;
      }
    });
  }

  Widget _buildSquare(int row, int col) {
    bool isLightSquare = (row + col) % 2 == 0;
    Color squareColor = isLightSquare ? Colors.brown[300]! : Colors.brown[700]!;

    return GestureDetector(
      onTap: () => _selectSquare(row, col),
      child: Container(
        color: squareColor,
        child: Center(
          child: _buildPiece(board[row][col]),
        ),
      ),
    );
  }

  Widget _buildPiece(String? piece) {
    if (piece == null) return SizedBox.shrink();

    IconData pieceIcon;
    Color pieceColor =
        piece == piece.toUpperCase() ? Colors.white : Colors.black;

    // Map chess piece symbols to icons.
    switch (piece.toLowerCase()) {
      case 'p':
        pieceIcon = Icons.circle;
        break;
      case 'r':
        pieceIcon = Icons.home;
        break;
      case 'n':
        pieceIcon = Icons.sports_kabaddi;
        break;
      case 'b':
        pieceIcon = Icons.change_history;
        break;
      case 'q':
        pieceIcon = Icons.star;
        break;
      case 'k':
        pieceIcon = Icons.emoji_events;
        break;
      default:
        return SizedBox.shrink();
    }

    return Icon(
      pieceIcon,
      color: pieceColor,
      size: 32,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chess Simulator'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
            ),
            itemCount: 64,
            itemBuilder: (BuildContext context, int index) {
              int row = index ~/ 8;
              int col = index % 8;
              return _buildSquare(row, col);
            },
          ),
        ),
      ),
    );
  }
}

/*class ChessBoardView extends StatefulWidget {
  const ChessBoardView({super.key});

  @override
  State<ChessBoardView> createState() => _ChessBoardViewState();
}

class _ChessBoardViewState extends State<ChessBoardView> {
  Widget chesswidget(int row, int colum) {
    bool value = (row + colum) % 2 == 0;
    Color valueColor = value ? Colors.white : Colors.black;
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AspectRatio(
        aspectRatio: 1.0,
        child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
            itemBuilder: (context, index) {
              int row = index ~/ 8;
              int column = index ~/ 8;
              return chesswidget(row, column);
            }),
      ),
    );
  }
}
*/