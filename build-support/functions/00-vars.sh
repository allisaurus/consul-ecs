# Default Image Names
GO_BUILD_CONTAINER_DEFAULT="consul-ecs-build-go"

# Whether to colorize shell output
COLORIZE=${COLORIZE-1}

# determine GOPATH and the first GOPATH to use for intalling binaries
GOPATH=${GOPATH:-$(go env GOPATH)}
case $(uname) in
    CYGWIN*)
        GOPATH="$(cygpath $GOPATH)"
        ;;
esac
MAIN_GOPATH=$(cut -d: -f1 <<< "${GOPATH}")

# Build debugging output is off by default
BUILD_DEBUG=${BUILD_DEBUG-0}

# default publish host is github.com - only really useful to use something else for testing
PUBLISH_GIT_HOST="${PUBLISH_GIT_HOST-github.com}"

# default publish repo is hashicorp/consul - useful to override for testing as well as in the enterprise repo
PUBLISH_GIT_REPO="${PUBLISH_GIT_REPO-hashicorp/consul-ecs.git}"

CONSUL_PKG_NAME="consul-ecs"

if test "$(uname)" == "Darwin"
then
   SED_EXT="-E"
else
   SED_EXT="-r"
fi

CONSUL_BINARY_TYPE=oss
