package puzzle11;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.function.Consumer;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Cavern {
	
	private List<List<Octopus>> octupi;
	
	public Cavern(String board) {
		String[] items = board.split("\n");
		List<List<Octopus>> cavernList = new ArrayList<>(items.length);
		for (int x = 0; x < items.length; x++) {
			cavernList.add(x, new ArrayList<Octopus> ());
			for (int y = 0; y < items[x].length(); y++) {
				int energyLevel = Integer.parseInt(
						String.valueOf(
								items[x].charAt(y)
						));
				cavernList.get(x).add(y, new Octopus(x, y, energyLevel));
			}
		}
		
		for (int x = 0; x < cavernList.size(); x++) {
			for (int y = 0; y < cavernList.get(x).size(); y++) {
				Octopus cur = cavernList.get(x).get(y);
				if (x > 0 ) {
					cur.addNeighbors(getNeigbors(cavernList.get(x -1 ), y));
				}
				if (y > 0 ) {
					cur.addNeighbors(cavernList.get(x).get(y-1));
				}
				if (y < cavernList.get(x).size() -1 ) {
					cur.addNeighbors(cavernList.get(x).get(y + 1));
				}
				if (x < cavernList.get(x).size() -1 ) {
					cur.addNeighbors(getNeigbors(cavernList.get(x + 1 ), y));
				}
			}
		}
		
		octupi = cavernList;
	}
	
	private List<Octopus> getNeigbors(List<Octopus> line, int index ) {
		List<Octopus> result = new ArrayList<Octopus>(3);
		if (index > 0 ) {
			result.add(line.get(index - 1));
		}
		result.add(line.get(index));
		if (index < line.size() - 1 ) {
			result.add(line.get(index + 1));
		}
		
		return result;
	}
	
	public int nextGeneration() {
		increaseEnergylevels();
		flash();
		int flashed = octupi.stream().flatMap(o -> o.stream()).mapToInt((o) -> o.hasFlashed() ? 1 : 0).sum();
		resetFlashes();
		return flashed;
	}
	
	public int nextGeneration(int i) {
		return IntStream.rangeClosed(1, i).map(step -> nextGeneration()).sum();
	}
	
	private void increaseEnergylevels() {
		octopiOperation(Octopus::increaseEnergyLevel);
	}
	
	private void flash() {
		List<Octopus> changed = octupi.stream().flatMap(o -> o.stream()).collect(Collectors.toList());
		while (!changed.isEmpty()) {
			changed = changed.stream().map(Octopus::tryFlash).flatMap(o -> o.stream()).collect(Collectors.toList());
		}
	}
	
	
	private void resetFlashes() {
		octopiOperation(Octopus::resetFlash);
	}
	
	private void octopiOperation(Consumer<? super Octopus> consumer) {
		octupi.stream().flatMap(o -> o.stream()).forEach(consumer);
	}
	

}
