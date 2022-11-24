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
	for i := 1; i < 100000; i++ {
		if (i % 2) == 1 {
			out <- i
		}
	}
}

func sieve(in <-chan int, out chan<- int) {
	// Fill in
	var own int = <-in
	var input int = <-in
	for {
		if input%own != 0 {
			out <- input
		}
		input = <-in
	}
}

func main() {
	// Declare channels
	var seiveChannels [N]chan int

	// Initialize channels
	for i := 0; i < N; i++ {
		seiveChannels[i] = make(chan int)
	}

	var oddsChannel = make(chan int)

	fmt.Println("The first", N, "prime numbers are:")

	// Connect/start goroutines
	go odds(oddsChannel)
	go sieve(oddsChannel, seiveChannels[0])
	for i := 1; i < N; i++ {
		go sieve(seiveChannels[i-1], seiveChannels[i])
	}

	// Await termination

	fmt.Println("Done!")
}
