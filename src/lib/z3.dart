import 'package:z3/z3.dart';
import 'dart:ffi';

class Z3Solver {
  Z3Solver() {
    libz3Override = DynamicLibrary.open('/usr/lib/x86_64-linux-gnu/libz3.so');
  }

  List<int>? solveLP(List<List<int>> A, List<int> b) {
    var opt = optimize();

    if (A.isEmpty || A[0].isEmpty || A.length != b.length) {
      throw ArgumentError('Invalid dimensions for A or b');
    }

    var numRows = A.length;
    var numCols = A[0].length;

    var x = List.generate(numCols, (i) => constVar('x$i', intSort));

    // var zero = rat(IntNumeral.from(0).toRat());
    var zero = IntNumeral.from(0);
    for (var xi in x) {
      opt.add(ge(xi, zero));
    }

    for (int i = 0; i < numRows; i++) {
      var rowTerms = <Expr>[];
      for (int j = 0; j < numCols; j++) {
        var value = A[i][j];
        if (value != 0) {
          // var coeff = rat(IntNumeral.from(value).toRat());
          var coeff = IntNumeral.from(value);
          rowTerms.add(mul(coeff, x[j]));
        }
      }

      var rowSum = rowTerms.isEmpty ? zero : addN(rowTerms);
      // var rowRhs = rat(IntNumeral.from(b[i]).toRat());
      var rowRhs = IntNumeral.from(b[i]);
      opt.add(eq(rowSum, rowRhs));
    }

    var objectiveFunction = addN(x);
    opt.minimize(objectiveFunction);

    if (!(opt.check() ?? false)) {
      return null;
    }

    var model = opt.getModel();
    var solution = x.map((xi) => model.eval(xi)!.toInt()).toList();
    return solution;
  }
}
