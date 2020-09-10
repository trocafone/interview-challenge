<?php declare(strict_types=1);

// #################################################
// Remove this file and create your own model's test
// #################################################

use Trocafone\Example;
use PHPUnit\Framework\TestCase;


final class ExampleTest extends TestCase
{
    private Example $exampleInstance;

    protected function setUp(): void
    {
        $this->exampleInstance = new Example();
    }

    public function testShouldSumTwoPositiveNumbers(): void
    {
        $result = $this->exampleInstance->sum(1,2);
        $this->assertEquals(3, $result);
    }

    public function testShouldBeCommutative(): void
    {
        $result = $this->exampleInstance->sum(2,1);
        $this->assertEquals(3, $result);
    }

    public function testShouldSumWithZero(): void
    {
        $result = $this->exampleInstance->sum(0,1);
        $this->assertEquals(1, $result);
    }

    public function testShouldSumZeroPlusZero(): void
    {
        $result = $this->exampleInstance->sum(0,0);
        $this->assertEquals(0, $result);
    }

    public function testShouldSumPositiveAndNegativeNumbers(): void
    {
        $result = $this->exampleInstance->sum(1,-2);
        $this->assertEquals(-1, $result);
    }

    public function testSumPositiveAndNegativeNumbersShouldBeCommutative(): void
    {
        $result = $this->exampleInstance->sum(-2,1);
        $this->assertEquals(-1, $result);
    }
}
