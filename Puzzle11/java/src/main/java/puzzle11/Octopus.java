package puzzle11;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class Octopus {
	
	private final int xindex;
	private final int yindex;
	
	private int energyLevel;
	private boolean flashed; 
	
	private List<Octopus> neighbors = new ArrayList<>(8);
	
	public Octopus(int xindex, int yindex, int energyLevel) {
		this.xindex = xindex;
		this.yindex = yindex;
		this.energyLevel = energyLevel;
	}
	
	public int increaseEnergyLevel() {
		return ++this.energyLevel;
	}
	
	@Override
	public String toString() {
		return "Octopus [xindex=" + xindex + ", yindex=" + yindex + ", energyLevel=" + energyLevel + ", flashed="
				+ flashed + ", neighbors=" + neighbors + "]";
	}

	public List<Octopus> tryFlash() {
		List<Octopus> affectedNeighbors = new ArrayList<>();
		if (flashed ) {
			return Collections.emptyList();
		}
		flashed = energyLevel > 9; 
		if (flashed) {
			for (Octopus octopus : neighbors) {
				octopus.increaseEnergyLevel();
			}
			affectedNeighbors.addAll(neighbors);
		}
		return affectedNeighbors;
	}
	
	public boolean hasFlashed() {
		return flashed;
	}
	
	public void resetFlash() {
		if (flashed) {
			energyLevel = 0;
		}
		flashed = false;
	}

	public List<Octopus> getNeighbors() {
		return neighbors;
	}
	
	public void addNeighbors(Octopus...octopus ) {
		this.neighbors.addAll(Arrays.asList(octopus));
	}

	public void setNeighbors(List<Octopus> neighbors) {
		this.neighbors = neighbors;
	}

	public void addNeighbors(List<Octopus> neigbors) {
		this.neighbors.addAll(neigbors);
		
	}
	
	

}
