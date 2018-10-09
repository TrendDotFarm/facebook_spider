#!/bin/sh -ev

# Redirect facebook.com to localhost
cp /etc/hosts hosts.bak
echo "127.0.0.1 facebook.com" | sudo tee -a /etc/hosts

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
mv hosts.bak /etc/hosts
rm output.json
