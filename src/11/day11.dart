import '../lib/io.dart';

class Node {
  final String name;
  final List<String> connections;

  Node(this.name, this.connections);

  static Map<String, Node> parseGraph(List<String> data) {
    var graph = <String, Node>{};
    for (var line in data) {
      var parts = line.split(':');
      var name = parts[0];
      var connections = parts[1].split(' ').where((s) => s.isNotEmpty).toList();
      graph[name] = Node(name, connections);
    }
    return graph;
  }
}

int countPaths(Map<String, Node> graph, String nodeName) {
  if (nodeName == 'out') {
    return 1;
  }

  var paths = 0;
  for (var name in graph[nodeName]!.connections) {
    paths += countPaths(graph, name);
  }
  return paths;
}

part1(data) {
  var graph = Node.parseGraph(data);
  return countPaths(graph, 'you');
}

part2(data) {
  return 0;
}

void main() async {
  final input = await FileUtils.readFileAsLines('src/11/input.txt');

  print('Day 11, part1: ${part1(input)}');
  print('Day 11, part2: ${part2(input)}');
}
