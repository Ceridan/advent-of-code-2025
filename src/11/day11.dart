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

int countPaths(Map<String, Node> graph, String nodeName, bool seenFft,
    bool seenDac, Map<(String, bool, bool), int> cache) {
  if (nodeName == 'out') {
    return (seenFft && seenDac) ? 1 : 0;
  }

  var cacheKey = (nodeName, seenFft, seenDac);
  if (cache.containsKey(cacheKey)) {
    return cache[cacheKey]!;
  }

  var newSeenFft = (seenFft || (nodeName == 'fft'));
  var newSeenDac = (seenDac || (nodeName == 'dac'));
  var paths = 0;
  for (var name in graph[nodeName]!.connections) {
    paths += countPaths(graph, name, newSeenFft, newSeenDac, cache);
  }
  cache[cacheKey] = paths;
  return paths;
}

part1(data) {
  var graph = Node.parseGraph(data);
  return countPaths(graph, 'you', true, true, {});
}

part2(data) {
  var graph = Node.parseGraph(data);
  return countPaths(graph, 'svr', false, false, {});
}

void main() async {
  final input = await FileUtils.readFileAsLines('src/11/input.txt');

  print('Day 11, part1: ${part1(input)}');
  print('Day 11, part2: ${part2(input)}');
}
