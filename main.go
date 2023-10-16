package main

import (
	"fmt"

	"github.com/kjpopov/swig-test/example"
)

func main() {
	math := example.NewMath()
	result := math.Add(2, 3)
	fmt.Println(result)
}
