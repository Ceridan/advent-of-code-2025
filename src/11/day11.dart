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

class NodeState {
  final int noneCount;
  final int fftCount;
  final int dacCount;
  final int bothCount;

  NodeState(this.noneCount, this.fftCount, this.dacCount, this.bothCount);
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

NodeState countPathsFftDac(
    Map<String, Node> graph, String nodeName, Map<String, NodeState> visited) {
  if (nodeName == 'out') {
    return NodeState(1, 0, 0, 0);
  }

  if (visited.containsKey(nodeName)) {
    return visited[nodeName]!;
  }

  var noneCount = 0;
  var fftCount = 0;
  var dacCount = 0;
  var bothCount = 0;
  for (var name in graph[nodeName]!.connections) {
    var state = countPathsFftDac(graph, name, visited);
    noneCount += state.noneCount;
    fftCount += state.fftCount;
    dacCount += state.dacCount;
    bothCount += state.bothCount;
  }

  if (nodeName == 'fft') {
    bothCount += dacCount;
    fftCount += noneCount;
    noneCount = 0;
  } else if (nodeName == 'dac') {
    bothCount += fftCount;
    dacCount += noneCount;
    noneCount = 0;
  }

  var newState = NodeState(noneCount, fftCount, dacCount, bothCount);
  visited[nodeName] = newState;
  return newState;
}

part1(data) {
  var graph = Node.parseGraph(data);
  return countPaths(graph, 'you');
}

part2(data) {
  var graph = Node.parseGraph(data);
  var counts = countPathsFftDac(graph, 'svr', {});
  return counts.bothCount;
}

void main() async {
  final input = await FileUtils.readFileAsLines('src/11/input.txt');

  print('Day 11, part1: ${part1(input)}');
  print('Day 11, part2: ${part2(input)}');
}
