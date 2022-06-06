#!/bin/bash

# WARNING:
# Running coverage tests with kdbx 3 seems to be too slow right now, so we only run kdbx 4 tests
# (kdbx4 with argon2 runs on native code, so no code coverage is collected there, vs.
# kdbx3's AES KDF runs in dart).
#
# This is way too slow. Probably because of cryptography with coverage colleciton.
# https://github.com/dart-lang/coverage/issues/261
#
# This script requires `jq`, `curl`, `git`.

set -xeu

cd "${0%/*}"/..

dart pub get
dart pub global activate coverage

fail=false
dart test --coverage coverage || fail=true
echo "fail=$fail"

# shellcheck disable=SC2038
# shellcheck disable=SC2046
jq -s '{coverage: [.[].coverage] | flatten}' $(find coverage -name '*.json' | xargs) > coverage/merged_json.cov

dart pub global run coverage:format_coverage -i coverage/merged_json.cov -l --report-on lib --report-on test > coverage/lcov.info

bash <(curl -s https://codecov.io/bash) -f coverage/lcov.info


test "$fail" == "true" && exit 1

echo "Success 🎉️"

exit 0

#pub get
#pub global activate test_coverage
#
#fail=false
#pub global run test_coverage || fail=true
#echo "fail=$fail"
#bash <(curl -s https://codecov.io/bash) -f coverage/lcov.info
#
#test "$fail" == "true" && exit 1
#
#echo "Success 🎉️"
#
#exit 0
