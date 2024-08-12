export GOPATH=$(go env GOPATH)
export GOBIN=$(go env GOBIN)
export GOTOOLCHAIN=$(curl -s -L "https://go.dev/VERSION?m=text" | head -n 1)+auto
