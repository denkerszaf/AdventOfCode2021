package puzzle12;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

public class Cave {

	@Override
	public String toString() {
		return "Cave [name=" + name + ", exits=" + exits.stream().map(Cave::getName).reduce("", (previous, cur) -> previous + "," + cur) + "]";
	}

	private final String name;
	
	public String getName() {
		return name;
	}

	private final Set<Cave> exits = new HashSet<>();
	
	public Cave(String name) {
		this.name = name;
	}

	@Override
	public int hashCode() {
		return Objects.hash(name);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Cave other = (Cave) obj;
		return Objects.equals(name, other.name);
	}

	public void addExit(Cave src) {
		exits.add(src);
	}
	
	public boolean isBig() {
		return name.matches("^[A-Z]+$");
	}

	public Set<Cave> getExits() {
		return exits;
	}


	
	
}
