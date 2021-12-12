package puzzle11;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
	
 

	public static void main(String[] args) throws IOException {
		String input = Files.readString(Path.of("input"));
		part1(input);
		
		part2(input);
	}

	private static void part1(String input) {
		Cavern cavern = new Cavern(input);
		int flashes = cavern.nextGeneration(100);
		System.out.println("After 100 generations, there have been " + flashes + " flashes in the cavern");
	}
	
	private static void part2(String input) {
		Cavern cavern = new Cavern(input);
		int firstSyncFlash = cavern.getNextSimultaneousFlash();
		System.out.println("The first synchronous flash will be after " + firstSyncFlash + " generations");
		
	}


}
