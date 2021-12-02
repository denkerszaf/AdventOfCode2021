var main  = require('./index');

const testInput = [199,200 ,208 ,210 ,200 ,207 ,240 ,269 ,260 ,263 ];

it("should return correct results", () => {
	expect(main.getDepthReadings(testInput)).toBe(7);
});
it("should increase from 998 to 1024", () => {
	expect(main.getDepthReadings([998, 1024])).toBe(1);
});
