.PHONY: default
.PHONY: clean
default:
	latexmk   -pdflatex  -latexoption='-shell-escape' main.tex
clean: 
	latexmk -c
	- rm -r _minted-main
read: default
	xdg-open main.pdf 2>/dev/null &
