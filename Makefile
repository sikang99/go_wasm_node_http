#
# Makefile by Stoney
#
all: usage

usage:
	@echo ""
	@echo "usage: make [edit|copy|build|run|docker]"
	@echo ""

# ----------------------------------------------------------------
edit e:
	@echo ""
	@echo "make (edit) [docker|readme|make]"
	@echo ""

edit-docker ed:
	vi Dockerfile

edit-readme er:
	vi README.md

edit-make em:
	vi Makefile

# ----------------------------------------------------------------
clean:
	rm -f *.wasm

copy:
	cp $(GOROOT)/misc/wasm/wasm_exec.js .

build b:
	GOOS=js GOARCH=wasm go build -o hello.wasm hello.go

run r:	# http://localhost:3000
	node wasm_exec.js hello.wasm

# ----------------------------------------------------------------
docker d:
	@echo ""
	@echo "make (docker) [edit|build|run]"
	@echo ""

docker-edit de:
	vi Dockerfile

docker-build db:
	docker build -t go-node

docker-run dr:
	docker run -t -p 3000:3000 go-node

# ----------------------------------------------------------------
git-update gu:
	git add Makefile Dockerfile
	git commit -m "add Makefile Dockerfile"
	git config credential.helper store
	git push https://github.com/sikang99/go_wasm_node_http.git

# ----------------------------------------------------------------
