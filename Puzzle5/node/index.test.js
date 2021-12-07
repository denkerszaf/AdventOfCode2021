const main = require("./index");

let input = new Array(
	"0,9 -> 5,9",
	"9,4 -> 3,4",
	"2,2 -> 2,1",
	"7,0 -> 7,4",
	"0,9 -> 2,9",
	"3,4 -> 1,4",
);

let withDiagonals = new Array(
	"0,9 -> 5,9",
	"8,0 -> 0,8",
	"9,4 -> 3,4",
	"2,2 -> 2,1",
	"7,0 -> 7,4",
	"6,4 -> 2,0",
	"0,9 -> 2,9",
	"3,4 -> 1,4",
	"0,0 -> 8,8",
	"5,5 -> 8,2"
);


const output = [ 
	".......1..", 
	"..1....1..", 
	"..1....1..",
	".......1..",
	".112111211",
	"..........",
	"..........",
	"..........",
	"..........",
	"222111...."].join("\n");
	
const outputWithDiagonals = 
`
1.1....11.
.111...2..
..2.1.111.
...1.2.2..
.112313211
...1.2....
..1...1...
.1.....1..
1.......1.
222111....
`.trim();

it('should render a line',() => {
	expect(main.renderLine("0,9 -> 5,9")).toStrictEqual([
		[0,9],
		[1,9],
		[2,9],
		[3,9],
		[4,9],
		[5,9]
		]);
	}
);
it('renders a pair', () => {
		expect(main.renderDiagram(["2,2 -> 2,1"])).toBe([ 
	"...", 
	"..1", 
	"..1"
	].join("\n"));
})

it('should render a horizontal line', () => {
	expect(main.renderLine("2,2 -> 2,1")).toStrictEqual([
		[2,1], [2,2]
	])
});
it('should display a diagram', () => {
	expect(main.renderDiagram(input)).toBe(output);
})

it('should recognize diagonals', () => {
	expect(main.renderDiagram(withDiagonals)).toBe(outputWithDiagonals);
})
it('should output the correct number of crosssections', () => {
	expect(main.countCrossSections(main.createDiagram(input))).toBe(5);
})