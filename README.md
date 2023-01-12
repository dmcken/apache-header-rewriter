# Apache header rewriter

Uses Apache to rewrite headers in a header including currently invalid headers (e.g. those containing underscores). 
 
Problem definition:
At the current time (2023) underscores and other characters are not allowed in http headers. Web servers like nginx can transparently pass these invalid headers through using directives like ignore_invalid_headers and underscores_in_headers. In a web server stack this is only the first step, application servers like django also tend to filter these invalid headers and thus its best if there is a desired header it be re-written to a form that can be used.

Solution:
Apache's method uses regexes and thus allows an arbritrary pattern to be matched and assigned to a variable that can then be assigned to another header.

```
# https://httpd.apache.org/docs/trunk/env.html#fixheader
#
# The below creates a API-KEY header using the value from api_key which is invalid due to the underscore.
SetEnvIfNoCase ^api_key$ ^(.*)$ fix_accept_encoding=$1
RequestHeader set API-KEY %{fix_accept_encoding}e env=fix_accept_encoding
```

