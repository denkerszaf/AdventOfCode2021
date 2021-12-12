package puzzle12;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ComplexEnterable implements Enterable {

	@Override
	public boolean mayBeEntered(List<Cave> caves, Cave next) {
		if (next.isBig()) {
			return true;
		}
		if (next.getName().equals("start")) {
			return false;
		}
		
		boolean visitedTwice = hasASmallCaveBeenVisitedTwice(caves);
		
		return !visitedTwice || caves.stream().filter(c -> next.equals(c)).findFirst().isEmpty();
	}

	private boolean hasASmallCaveBeenVisitedTwice(List<Cave> caves) {
		Map<Cave, Integer> visits = new HashMap<>();
		for (Cave c : caves) {
			if (!c.isBig()) {
				Integer currVisits = visits.getOrDefault(c, Integer.valueOf(0));
				visits.put(c, currVisits + 1); 
			}
		}
		
		return visits.containsValue(2);
	}

}
