// #################################################
// Remove this file and create your own model's test
// #################################################

import Example from '../src/example'

describe('Example Model', () => {
  let example;
  beforeEach(() => {
    example = new Example();
  })

  describe('#sum', () => {
    it('should sum two positive numbers', () => {
      expect(example.sum(1,2)).toBe(3)
    });

    it('should be commutative', () => {
      expect(example.sum(2,1)).toBe(3)
    });

    it('should sum with 0', () => {
      expect(example.sum(0,1)).toBe(1)
    });

    it('should sum with 0 commutative', () => {
      expect(example.sum(0, 1)).toBe(1)
    });

    it('should sum with both 0', () => {
      expect(example.sum(0, 0)).toBe(0)
    });

    it('should sum a positive and a negative number', () => {
      expect(example.sum(1,-2)).toBe(-1)
    });

    it('should sum a positive and a negative number and be commutative', () => {
      expect(example.sum(-2, 1)).toBe(-1)
    });

    it('should sum two negative negative numbers', () => {
      expect(example.sum(-31,-2)).toBe(-33)
    });
  });

});
