package puzzle12;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Stream;

public class Maze {
	
	private Map<String, Cave> caves = new HashMap<>();
	
	private final Enterable enterable; 
	
	public Maze(String input) {
		this.enterable = new SimpleEnterable();
		Stream.of(input.split("\n")).forEach((line) -> this.addConnection(line));
	}
	
	public Maze(String input, Enterable enterable) {
		this.enterable = enterable;
		Stream.of(input.split("\n")).forEach((line) -> this.addConnection(line));
	}


	private void addConnection(String string1) {
		String[] caves = string1.split("-");
		Cave src = getCave(caves[0]);
		Cave target = getCave(caves[1]);
		
		src.addExit(target);
		target.addExit(src);
	}
	
	private Cave getCave(String cavename) {
		if (!caves.containsKey(cavename)) {
			caves.put(cavename, new Cave(cavename)); 
		}
		return caves.get(cavename);
	}

	public Set<List<Cave>> getDistinctPaths() {
		Cave start = caves.get("start");
		Cave end = caves.get("end");
		return dfs(start, end, Collections.singletonList(start));
	}
	
	
	public Set<List<Cave>> dfs(Cave node, Cave goal, List<Cave> caves) {
		if (node.equals(goal)) {
			List<Cave> navigation = new ArrayList<>(caves);
			return Collections.singleton(navigation);
		} else {
			Set<Cave> possibleExits = node.getExits();
			Set<List<Cave>> possibleNavigations = new HashSet<>();
			for (Cave next: possibleExits ) {
				if (enterable.mayBeEntered(caves, next) ) {
					List<Cave> newCaveList = new ArrayList<Cave>(caves);
					newCaveList.add(next);
					possibleNavigations.addAll(dfs(next, goal, newCaveList));
				}
			}
			return possibleNavigations;
		}
	}
}
