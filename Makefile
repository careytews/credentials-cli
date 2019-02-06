
GOFILES=tn-creds

all: ${GOFILES}

GODEPS=go/.goflags go/.creds

SOURCES=tn-creds.go mgmt.go

tn-creds: ${SOURCES} ${GODEPS}
	GOPATH=$$(pwd)/go go build ${SOURCES}

tn-creds.macos:${SOURCES} ${GODEPS}
	GOOS=darwin GOARCH=386 GOPATH=$$(pwd)/go go build -o $@ ${SOURCES}

upload:
	gsutil cp tn-creds.macos \
	    gs://download.trustnetworks.com/tn-creds/tn-creds.macos

go/.goflags:
	GOPATH=$$(pwd)/go go get github.com/jessevdk/go-flags
	touch $@

go/.creds:
	GOPATH=$$(pwd)/go go get github.com/trustnetworks/credentials
	touch $@

clean:
	rm -rf ${GOFILES}
	rm -rf go

