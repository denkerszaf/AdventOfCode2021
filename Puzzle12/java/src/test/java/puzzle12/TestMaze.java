package puzzle12;

import static org.junit.Assert.assertEquals;

import org.junit.jupiter.api.Test;

public class TestMaze {
	
	@Test
	public void smallInput() {
		Maze maze = new Maze("start-A\n"
				+ "start-b\n"
				+ "A-c\n"
				+ "A-b\n"
				+ "b-d\n"
				+ "A-end\n"
				+ "b-end");
		assertEquals(10, maze.getDistinctPaths().size());
	}
	
	@Test
	public void slightlyLargerExample() {
		Maze maze = new Maze("dc-end\n"
				+ "HN-start\n"
				+ "start-kj\n"
				+ "dc-start\n"
				+ "dc-HN\n"
				+ "LN-dc\n"
				+ "HN-end\n"
				+ "kj-sa\n"
				+ "kj-HN\n"
				+ "kj-dc");
		assertEquals(19, maze.getDistinctPaths().size());
		
	}
	
	@Test
	public void largerExample() {
		Maze maze = new Maze("fs-end\n"
				+ "he-DX\n"
				+ "fs-he\n"
				+ "start-DX\n"
				+ "pj-DX\n"
				+ "end-zg\n"
				+ "zg-sl\n"
				+ "zg-pj\n"
				+ "pj-he\n"
				+ "RW-he\n"
				+ "fs-DX\n"
				+ "pj-RW\n"
				+ "zg-RW\n"
				+ "start-pj\n"
				+ "he-WI\n"
				+ "zg-he\n"
				+ "pj-fs\n"
				+ "start-RW");
		assertEquals(226, maze.getDistinctPaths().size());
		
		
	}

}
