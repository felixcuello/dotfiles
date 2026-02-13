all: neomutt

build:
	docker build -t neomutt .

shell:
	docker run -v ${HOME}/Mail/palermo:/root/Mail/palermo -v ${PWD}:/app -ti neomutt bash

neomutt:
	docker run -v ${HOME}/Mail/palermo:/root/Mail/palermo -v ${PWD}:/app -ti ./neomutt.sh
