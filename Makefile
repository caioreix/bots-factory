.PHONY: make

deps:
	@go mod tidy
	@go mod download
	
linter:
	@curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.43.0

lint:
	@golangci-lint run ./...

test:
	@go test -v -race ./...
