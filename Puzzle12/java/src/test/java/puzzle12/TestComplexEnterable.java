package puzzle12;

import static org.junit.Assert.assertFalse;

import java.util.List;
import java.util.stream.Collectors;

import org.junit.Test;

public class TestComplexEnterable {

	private Enterable out = new ComplexEnterable();
	
	@Test
	public void firstElement() {

		List<Cave> map = List.of("start","A","b","A","b","A","c","A").stream().map(Cave::new).collect(Collectors.toList());
		
		assertFalse(out.mayBeEntered(map, new Cave("c")));		
	}
	
	@Test
	public void startMayNotBeReentered() {
		List<Cave> input = caveFromString("start,A");
		
		assertFalse(out.mayBeEntered(input, new Cave("start")));
	}
	
	
	private List<Cave> caveFromString(String input) {
		return List.of(input.split(",")).stream().map(Cave::new).collect(Collectors.toList());
	}
}
