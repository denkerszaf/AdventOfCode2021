package puzzle11;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {

	public static void main(String[] args) throws IOException {
		String currentDirectory = System.getProperty("user.dir");
	    System.out.println("The current working directory is " + currentDirectory);
		
		String input = Files.readString(Path.of("input"));
		Cavern cavern = new Cavern(input);
		int flashes = cavern.nextGeneration(100);
		System.out.println("After 100 generations, there have been " + flashes + " flashes in the cavern");
	}

}
