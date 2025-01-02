package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
)

func main() {
	cmd := exec.Command("git", "rev-parse", "HEAD")
	output, err := cmd.Output()
	if err != nil {
		log.Fatalf("Failed to get latest commit hash: %v", err)
	}

	filePath := "data/site_version.yml"
	f, err := os.Create(filePath)
	if err != nil {
		log.Fatalf("Failed to create file: %v", err)
	}
	defer f.Close()

	_, err = f.WriteString(fmt.Sprintf("version: %s\n", output[0:5]))
	if err != nil {
		log.Fatalf("Failed to write to file: %v", err)
	}
}
