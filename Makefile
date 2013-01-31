all: hakyll.html

hakyll.html: hakyll.md
	pandoc -t slidy -s hakyll.md -o hakyll.html

clean:
	rm hakyll.html
