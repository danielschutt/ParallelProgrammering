/*
   DTU 02158 Concurrent Programming
   Mandatory Assignment 4
   Fall 2022
*/

package main

import "fmt"

const N = 5

func odds(out chan<- int) {
	// Fill in
}

func sieve(in <-chan int, out chan<- int) {
	// Fill in
}

func main() {
	// Declare channels

	// Initialize channels

	fmt.Println("The first", N, "prime numbers are:")

	// Connect/start goroutines

	// Await termination

	fmt.Println("Done!")
}
