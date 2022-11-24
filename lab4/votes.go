package main

import (
	"fmt"
	"math/rand"
	"time"
)

type Votes struct{ a, b int }

func station(out chan<- Votes) {
	for i := 0; i < 10; i++ {
		//time.Sleep(time.Duration(rand.Intn(2000)) * time.Millisecond)
		aVotes := rand.Intn(100)
		out <- Votes{aVotes, 100 - aVotes}
	}
	close(out)
}

func collector(in1, in2 <-chan Votes, out chan<- Votes) {

	var tally1 Votes
	for {
		var v, ok = <-in1
		if !ok {
			break
		}
		tally1.a += v.a
		tally1.b += v.b

	}
	var tally2 Votes
	for {
		var v, ok = <-in2
		if !ok {
			break
		}
		tally2.a += v.a
		tally2.b += v.b
	}
	var final Votes
	final.a += tally1.a + tally2.a
	final.b += tally1.b + tally2.b
	out <- Votes{final.a, final.b}
	close(out)

}

func main() {
	rand.Seed(time.Now().UnixNano())
	var chans [14]chan Votes
	for i := range chans {
		chans[i] = make(chan Votes)
	}

	var res = make(chan Votes)
	go station(chans[6])
	go station(chans[7])
	go station(chans[8])
	go station(chans[9])
	go station(chans[10])
	go station(chans[11])
	go station(chans[12])
	go station(chans[13])
	go collector(chans[0], chans[1], res)
	go collector(chans[2], chans[3], chans[0])
	go collector(chans[4], chans[5], chans[1])
	go collector(chans[6], chans[7], chans[2])
	go collector(chans[8], chans[9], chans[3])
	go collector(chans[10], chans[11], chans[4])
	go collector(chans[12], chans[13], chans[5])

	var tally Votes
	for {
		var v, ok = <-res
		if !ok {
			break
		}
		tally.a += v.a
		tally.b += v.b
		fmt.Println("Current tally:", tally)
	}

	tot := tally.a + tally.b

	if tot != 1000 {
		fmt.Println("Tally issue:", tot)
	}

	var winner string
	switch {
	case tally.a > tally.b:
		winner = "A"
	case tally.a < tally.b:
		winner = "B"
	default:
		winner = "undetermined"
	}
	fmt.Printf("All votes counted. And the winner is: %s\n", winner)
	if winner == "B" {
		fmt.Println("A: This must be FRAUD!!!")
	}
}
