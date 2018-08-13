#!/bin/sh
set -ev

# Make facebook.com redirect to localhost

# Launch a MockWebServer

# Make MockWebServer reply with theguardian.input.json contents
../facebook_spider theguardian foo_token > output.json
cmp output.json theguardian.expected_output.json

# Make MockWebServer reply with small delay
../facebook_spider theguardian foo_token > output.json
cmp output.json theguardian.exected_output.json

# Make MockWebServer reply with big delay
(! ../facebook_spider theguardian foo_token)

# Make MockWebServer reply with errors
(! ../facebook_spider theguardian foo_token)

# Restore facebook.com address resolution and cleanup

rm output.json
