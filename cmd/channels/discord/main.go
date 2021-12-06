package main

import (
	"fmt"
	"os"
	"os/signal"
	"syscall"
)

func main() {
	done := make(chan os.Signal, 1)
	signal.Notify(done, syscall.SIGINT, syscall.SIGTERM)

	fmt.Println("running...")
	<-done
	fmt.Println("graceful shutdown.")
}
