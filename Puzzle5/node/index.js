const regex = /(\d+),(\d+) -> (\d+),(\d+)/;

const fs = require('fs');

function order(a, b) {

	return [a,b].sort(sortElements);

}

function sortElements(a, b) {
	if (a[0] === b[0]) {
		return a[1] - b[1];
	}
	return a[0] - b[0];
}

function renderLine(line) {
	console.log(line);
	const input = regex.exec(line);
	console.log(input);
	const [ [startx, starty], [endx, endy]] = order(  
		[ parseInt(input[1]) , parseInt(input[2]) ], 
		[ parseInt(input[3]), parseInt(input[4]) ]
	)
	
	
	values = [];
	if (starty === endy) { // horizontal line
		startLine = Math.min(startx, endx)
		finishline = Math.max(startx, endx);
		values =  Array(endx - startx + 1).fill().map((element, index) => [ startLine + index, starty]);
	} else if (startx === endx ){               // vertical line
		values = Array(endy - starty + 1).fill().map((element, index) => [ startx , starty + index]);
	} else { // diagonal
		y = starty;  
		for ( x = startx ; x <= endx; x++) {
			values.push([x, y]);
			y += Math.sign(endy - starty)
		}
	}
	return values;
}

function createDiagramLine(line) {
	return line.reduce(
		(previous, item) => { 
			if (item === 0) {
				return previous + "."
			} else {
				return previous + item
			} 
		}, "");
}

function createDiagram(input) {
	
		elements = input.map(renderLine)
		 .reduce((previous, current) => [ ...previous, ...current])
		 .sort(sortElements);
	
	maxx = elements.reduce((prev, curr) => Math.max(prev, curr[0]), 0);
	maxy = elements.reduce((prev, curr) => Math.max(prev, curr[1]), 0);
	
	
	diagram = Array(maxx + 1).fill().map(() => Array(maxy +1).fill(0));
	for (const val of elements) {
		diagram[val[1]][val[0]] += 1; 
	}
	
	return diagram;
}

function renderDiagram(input) {
	
	
	diagram = createDiagram(input);
	return diagram.map(createDiagramLine).reduce((previous, line) => previous + "\n" + line);
	
}

function countCrossSections(diagram) {
	
	return diagram.flat().reduce((previous, item) => { 
		return item > 1 ? previous + 1: previous
	}, 0); 
	
}

if (require.main === module) {
	fs.readFile('../input', 'utf8', function (err, data) {
		if (err) {
			console.log(err);
		}
		else {
			crosssections = countCrossSections(createDiagram(data.trim().split('\n')));
			console.log("there are " + crosssections +"crosssections in the diagram");
		}
	})
}

module.exports = {
	renderLine: renderLine,
	renderDiagram: renderDiagram,
	createDiagram: createDiagram,
	countCrossSections: countCrossSections,
}