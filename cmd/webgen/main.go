package main

import (
	"flag"
	"html/template"
	"io/ioutil"
	"log"
	"os"

	"github.com/gomarkdown/markdown"
)

type flags struct {
	indexFile    string
	markdownFile string
}

func main() {
	// Get the flags.
	var f flags
	flag.StringVar(&f.indexFile, "index", "templates/index.html", "the index file to generate")
	flag.StringVar(&f.markdownFile, "markdown", "templates/body.md", "the markdown body")
	flag.Parse()

	markdownFD, err := os.Open(f.markdownFile)
	if err != nil {
		log.Fatalf("could not open markdown file %s: %s\n", f.markdownFile, err)
	}
	defer markdownFD.Close()

	// Read the markdown.
	mardownBytes, err := ioutil.ReadAll(markdownFD)
	if err != nil {
		log.Fatalf("failed to read markdown file %s: %s\n", f.markdownFile, err)
	}

	// And covert it to html.
	htmlBytes := string(markdown.ToHTML(mardownBytes, nil, nil))

	// Execute the template.
	templateFile := template.Must(template.ParseFiles(f.indexFile))
	err = templateFile.Execute(os.Stdout, struct{ Body template.HTML }{template.HTML(htmlBytes)})
	if err != nil {
		log.Fatalf("failed to execute template %s: %s\n", f.indexFile, err)
	}
}
