// 2>/dev/null; e=$(mktemp); go build -o $e "$0"; $e "$@" ; r=$?; rm $e; exit $r

package main

import (
	"fmt"
	"os"
)

func main() {
	fmt.Printf("Hello World\n")
	os.Exit(5)
}
