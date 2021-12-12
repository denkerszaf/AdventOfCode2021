package puzzle12;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.Set;

public class Main {

	public static void main(String[] args) throws IOException {
		String input = Files.readString(Path.of("input"));
		
		Maze maze = new Maze(input);
		Set<List<Cave>> uniquePaths = maze.getDistinctPaths();
		
		System.out.println("There are " + uniquePaths.size() + " paths through the maze");
	}

}
