import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.Test;

import puzzle11.Cavern;

public class TestCavernList {
	
	@Test
	public void checkInput() {
		Cavern cavern = new Cavern("11111\n"
				+ "19991\n"
				+ "19191\n"
				+ "19991\n"
				+ "11111");
		assertEquals(9, cavern.nextGeneration());
	}
	
	@Test
	public void minimalInput() {
		Cavern cavern = new Cavern("01\n10");
		
		assertEquals(0, cavern.nextGeneration());
	}
	
	@Test
	public void minimalInputWithFlash() {
		Cavern cavern = new Cavern("09\n90");
		
		assertEquals(2, cavern.nextGeneration());
	}
	
	@Test
	public void manyGenerations() {
		Cavern cavern = new Cavern("5483143223\n"
				+ "2745854711\n"
				+ "5264556173\n"
				+ "6141336146\n"
				+ "6357385478\n"
				+ "4167524645\n"
				+ "2176841721\n"
				+ "6882881134\n"
				+ "4846848554\n"
				+ "5283751526");
		assertEquals(1656, cavern.nextGeneration(100));
	}

}
