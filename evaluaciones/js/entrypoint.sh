#!/bin/sh

echo "-> Starting evaluacion"
echo "Internal date:" $(date)
echo "Entry point args: ${*:-<none>}"
echo ""

run_lint () {
  export NODE_ENV='test'
  yarn run lint
}

run_tests () {
  export NODE_ENV='test'
  yarn run test
}

run_coverage () {
  export NODE_ENV='test'
  yarn run coverage
}

shell () {
    sh
}

COMMAND=$1; shift
case $COMMAND in
  shell)
    shell $*
  ;;
  coverage)
    run_coverage $*
  ;;
  lint)
    run_lint $*
  ;;
  test)
    run_tests $*
  ;;
  *)
    echo "[!] Invalid or no command specified. Available commands: test, lint, coverage, shell"
    exit 1
  ;;
esac

exit $?
