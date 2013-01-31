all: hakyll.html

hakyll.html: hakyll.md
	pandoc -t Slidy -s hakyll.md -o hakyll.html

clean:
	rm hakyll.html
